from keras.models import load_model
from keras.preprocessing.image import load_img, ImageDataGenerator, array_to_img, img_to_array
from keras.backend import tf as ktf
from scipy.misc import imresize
from trainmodel import generator_from_dir
import numpy as np
import sys

IMAGE_SIZE = 300
BATCH_SIZE = 8

def load_image_grid(filename):
    image = load_img(filename)
    img_array = np.array(image)
    height = img_array.shape[0] // IMAGE_SIZE
    width = img_array.shape[1] // IMAGE_SIZE
    sub_images = []
    for i in range(height):
        h_start = i * IMAGE_SIZE
        h_end = (i+1) * IMAGE_SIZE
        for j in range(width):
            w_start = j * IMAGE_SIZE
            w_end = (j+1) * IMAGE_SIZE
            image = np.copy(img_array[w_start:w_end, h_start:h_end])
            if image.shape == (300,300,3):
                sub_images.append(image)
    return sub_images

def predict_convnet(filename, to_predict):
    model = load_model(filename)
    image_gen = ImageDataGenerator()
    x_gen = generator_from_dir(image_gen, to_predict)
    predictions = model.predict_generator(x_gen,
        steps=800 // BATCH_SIZE)
    print(predictions)

def main():
    try:
        model_type = sys.argv[1]
        model_file = sys.argv[2]
        predict_file = sys.argv[3]
    except:
        print("Missing argument")
        return

    if model_type == "convnet":
        predict_convnet(model_file, predict_file)

if __name__ == "__main__":
    main()