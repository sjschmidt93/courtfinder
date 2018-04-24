from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D, Activation, Dropout, Flatten, Dense
from keras import backend as K
import sys
import win_unicode_console

win_unicode_console.enable()

BATCH_SIZE = 8
IMAGE_SIZE = 300

# ConvNet Following this Guide: https://blog.keras.io/building-powerful-image-classification-models-using-very-little-data.html

def generator_from_dir(image_generator, directory):
    """Creates a Keras generator to load image data from a directory"""
    data_generator = image_generator.flow_from_directory(
        directory,
        target_size=(IMAGE_SIZE,IMAGE_SIZE),
        batch_size=BATCH_SIZE,
        class_mode='binary',
    )
    return data_generator

def compile_convnet_model(input_shape):
    """Defines the convolutional neural network model"""
    model = Sequential()
    model.add(Conv2D(32, (3, 3), input_shape=input_shape))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))

    model.add(Conv2D(32, (3, 3)))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))

    model.add(Conv2D(64, (3, 3)))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))

    model.add(Flatten())
    model.add(Dense(256))
    model.add(Activation('relu'))
    model.add(Dropout(0.5))
    model.add(Dense(1))
    model.add(Activation('sigmoid'))

    model.compile(
        loss='binary_crossentropy',
        optimizer='adam',
        metrics=['accuracy'],
    )

    return model

def train_convnet_model(training_dir, validation_dir, output_file):
    """Trains a convolutional neural network from the given input files"""
    image_generator = ImageDataGenerator(
        rotation_range=40,
        width_shift_range=0.2,
        height_shift_range=0.2,
        rescale=1./255,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True,
        vertical_flip=True,
        fill_mode='nearest',
    )

    train_generator = generator_from_dir(image_generator, training_dir)
    validation_generator = generator_from_dir(image_generator, validation_dir)
    if K.image_data_format() == 'channels_first':
        input_shape = (3, IMAGE_SIZE, IMAGE_SIZE)
    else:
        input_shape = (IMAGE_SIZE, IMAGE_SIZE, 3)

    model = compile_convnet_model(input_shape)

    model.fit_generator(
        train_generator,
        steps_per_epoch=2000 // BATCH_SIZE,
        epochs=50,
        validation_data=validation_generator,
        validation_steps= 800 // BATCH_SIZE
    )

    model.save(output_file)

def main():
    try:
        training_type = sys.argv[1]
        training_dir = sys.argv[2]
        validation_dir = sys.argv[3]
        output = sys.argv[4]
    except:
        print("Missing argument")
        return

    if training_type == 'convnet':
        train_convnet_model(training_dir, validation_dir, output)
    else:
        print("Invalid training type")
        return

if __name__ == "__main__":
    main()