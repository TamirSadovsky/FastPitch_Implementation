#!/usr/bin/env bash

export CUDNN_V8_API_ENABLED=1  # Keep the flag for older containers
export TORCH_CUDNN_V8_API_ENABLED=1

: ${DATASET_DIR:="/content/drive/MyDrive/Deep_Audio/Data/out_wavs"}
: ${BATCH_SIZE:=1}
: ${FILELIST:="/content/drive/MyDrive/Deep_Audio/Data/ljs_audio_text_test_1.tsv"}
: ${AMP:=false}
: ${TORCHSCRIPT:=true}
: ${WARMUP:=0}
: ${REPEATS:=1}
: ${CPU:=false}
: ${PHONE:=true}
: ${CUDNN_BENCHMARK:=false}

# Paths to pre-trained models downloadable from NVIDIA NGC (LJSpeech-1.1)
FASTPITCH_LJ="/content/drive/MyDrive/Deep_Audio/FastPitch/FastPitch.pt"

# Mel-spectrogram generator (optional; can synthesize from ground-truth spectrograms)
: ${FASTPITCH=$FASTPITCH_LJ}

# Synthesis
: ${SPEAKER:=0}
: ${DENOISING:=0.01}

if [ ! -n "$OUTPUT_DIR" ]; then
    OUTPUT_DIR="./output/audio_$(basename ${FILELIST} .tsv)"
    [ "$AMP" = true ]     && OUTPUT_DIR+="_fp16"
    [ "$AMP" = false ]    && OUTPUT_DIR+="_fp32"
    [ -n "$FASTPITCH" ]   && OUTPUT_DIR+="_fastpitch"
    [ ! -n "$FASTPITCH" ] && OUTPUT_DIR+="_gt-mel"
    OUTPUT_DIR+="_denoise-"${DENOISING}
fi
: ${LOG_FILE:="$OUTPUT_DIR/nvlog_infer.json"}
mkdir -p "$OUTPUT_DIR"

echo -e "\nAMP=$AMP, batch_size=$BATCH_SIZE\n"

ARGS+=" --cuda"
ARGS+=" --dataset-path $DATASET_DIR"
ARGS+=" -i $FILELIST"
ARGS+=" -o $OUTPUT_DIR"
ARGS+=" --log-file $LOG_FILE"
ARGS+=" --batch-size $BATCH_SIZE"
ARGS+=" --denoising-strength $DENOISING"
ARGS+=" --warmup-steps $WARMUP"
ARGS+=" --repeats $REPEATS"
ARGS+=" --speaker $SPEAKER"
ARGS+=" --mel_only"
ARGS+=" --save-mels"
ARGS+=" --pitch-transform-shift 50"
[ "$CPU" = false ]        && ARGS+=" --cuda"
[ "$AMP" = true ]         && ARGS+=" --amp"
[ "$TORCHSCRIPT" = true ] && ARGS+=" --torchscript"
[ -n "$FASTPITCH" ]       && ARGS+=" --fastpitch $FASTPITCH"
[ "$PHONE" = true ]       && ARGS+=" --p-arpabet 1.0"
[[ "$CUDNN_BENCHMARK" = true && "$CPU" = false ]] && ARGS+=" --cudnn-benchmark"

cd "/content/drive/MyDrive/Deep_Audio/FastPitch"
python inference.py $ARGS "$@"