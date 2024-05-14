Link to GitHub:
https://github.com/TamirSadovsky/FastPitch_Implementation

Link to Medium story:
https://medium.com/@roei.benzion/fastpitch-overview-and-implementation-f51d070fe0fa 
First:
1. Unzip the submission folder.
2. cd /path/to/unzipped_submission
3. pip install -r requirements.txt
4. Make sure the environment is unix like and you have GPU on.
   
To run training:
1. chmod +x ./train.sh
2. bash train.sh

To run evaluation:
1. python Evaluation.py
The results are in:
1. Baseline comparison - Baseline in "./Audio_Ground_Truth/Reconstruct", model in "./output/audio_50_test_phrases_fp32_fastpitch_denoise-0.01"
2. Pitch shift - "./regular.wav" "./plus.wav", "./minus.wav"


We have created a colab notebook of the evaluation, providing a more comfortable environment to check the evalutation results.
This is done as follows:
Our dataset and model checkpoint are in our Google drive. We have shared the folders with you. Please follow these short steps:

1. Go to the "Shared with me" section in Google Drive.
2. Look for the folders named "LJSpeech-1.1" and "Deep Audio".
3. For each, right-click on the folder, then select 'Organize' -> 'Create shortcut' -> 'My Drive'.
4. Once you've added the folder to your Google Drive, proceed to run the next steps in the Colab notebook.

[Inference notebook](https://colab.research.google.com/drive/1dfpGbbJ_UBcvvUfqin07JDN6Bg9oM-kc) where we conducted the expiriments.

There is also a way to run training in colab:
[Training notebook](https://colab.research.google.com/drive/1lGeHuRnFLZqgw3-1WfM3k4cJBcf35Om3) where one can train the model using the code modifications we made over the official implementation.

Thank you!

