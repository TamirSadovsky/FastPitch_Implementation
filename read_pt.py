import torch
import librosa
import librosa.display
import matplotlib.pyplot as plt
import numpy as np

def read_pt_file(file_path):
    try:
        # Load the .pt file
        loaded_object = torch.load(file_path)

        # Process based on the type of the loaded object
        if isinstance(loaded_object, torch.Tensor):
            # Treat the data as a mel-spectrogram and plot it
            plot_mel_spectrogram(loaded_object)

        else:
            print("Loaded object is not a torch.Tensor. Cannot process as mel-spectrogram.")

    except Exception as e:
        print(f"Error occurred while reading the .pt file: {e}")

def plot_mel_spectrogram(tensor_data):
    # Convert tensor to numpy array
    audio_array = tensor_data.numpy()

    # Calculate mel-spectrogram using librosa
    mel_spec = librosa.feature.melspectrogram(y=audio_array[0], sr=44100)  # Adjust sr according to your audio sample rate

    # Convert power spectrogram to dB (log scale)
    mel_spec_db = librosa.power_to_db(mel_spec, ref=np.max)

    # Plotting the mel-spectrogram
    plt.figure(figsize=(10, 4))
    librosa.display.specshow(mel_spec_db, x_axis='time', y_axis='mel', sr=44100, fmax=8000)
    plt.colorbar(format='%+2.0f dB')
    plt.title('Mel Spectrogram')
    plt.xlabel('Time (seconds)')
    plt.ylabel('Frequency (Hz)')
    plt.tight_layout()
    plt.show()

# Provide the path to your .pt file
file_path = "LJ043-0030.pt"

# Call the function to read and process the .pt file
read_pt_file(file_path)
