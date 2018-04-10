from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D, Activation, Dropout, Flatten, Dense
from keras import backend as K
import sys

BATCH_SIZE = 16

def generator_from_dir(image_generator, directory):
        data_generator = image_generator.flow_from_directory(
            directory,
            target_size=(150,150),
            batch_size=BATCH_SIZE,
            class_mode='binary',
        )
        return data_generator

def compile_convnet_model(input_shape):
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
    model.add(Dense(64))
    model.add(Activation('relu'))
    model.add(Dropout(0.5))
    model.add(Dense(1))
    model.add(Activation('sigmoid'))

    model.compile(
        loss='binary_crossentropy',
        optimizer='rmsprop',
        metrics=['accuracy'],
    )

    return model

def train_convnet_model(training_dir, validation_dir, output_file):
    image_generator = ImageDataGenerator(
        rotation_range=40,
        width_shift_range=0.2,
        height_shift_range=0.2,
        rescale=1./255,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True,
        fill_mode='nearest',
    )

    train_generator = generator_from_dir(image_generator, training_dir)
    validation_generator = generator_from_dir(image_generator, validation_dir)
    if K.image_data_format() == 'channels_first':
        input_shape = (3, 150, 150)
    else:
        input_shape = (150, 150, 3)

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
        training_dir = sys.argv[1]
        validation_dir = sys.argv[2]
        output = sys.argv[3]
    except:
        print("Missing argument")
        return

    train_convnet_model(training_dir, validation_dir, output)

if __name__ == "__main__":
    main()