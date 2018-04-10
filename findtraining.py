import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
import sys
import os


def scan_image(filename):
    """Loads an image to be examined by the user"""
    image = mpimg.imread(filename)
    plt.ion()
    plt.show()

    choices, sub_images, location_name = display_subimages(image, filename)

    try:
        os.makedirs('images/training/yes')
        os.makedirs('images/training/no')
        print("Creating Training Directories")
    except:
        pass

    choices_flattened = choices.flatten()
    print("Saving images")
    for i,item in enumerate(choices_flattened):
        sub_image = sub_images[i]
        if item == 1:
            plt.imsave('images/training/yes/{}-{}'.format(location_name, i), sub_image)
        else:
            plt.imsave('images/training/no/{}-{}'.format(location_name, i), sub_image)
    print("Images Saved")

def display_subimages(image, filename):
    """Iterates through 300x300 blocks of a given image"""
    height = image.shape[0]
    width = image.shape[1]
    h_count = height // 300
    w_count = width // 300
    
    print("There are {} images".format(h_count * w_count))
    choices = np.zeros((h_count, w_count))
    sub_images = []
    # Iterate through 300x300 map squares
    i = 0
    while i < h_count:
        j = 0
        while j < w_count:
            show_image(i, height, j, width, image, sub_images)
            response = input("Does this contain a basketball court? (y/n) ")
            location_name = filename.split('.')[0]
            if response == 'b':
                if j > 0:
                    j -= 1
                else:
                    i -= 1
                    j = w_count - 1
            if response == 'y':
                choices[i,j] = 1
            else:
                choices[i,j] = 0
            plt.clf()
            j += 1
        i += 1
    plt.close()
    return choices, sub_images, location_name

def show_image(i, height, j, width, image, sub_images):
    """Displays a sub-image of a larger image at the given location"""
    h_start = 300 * i
    h_end = min(300 * (i+1), height)
    w_start = 300 * j
    w_end = min(300 * (j+1), width)
    sub_image = np.copy(image[h_start:h_end,w_start:w_end,:])
    sub_image[:,:,3] = 255
    sub_images.append(sub_image)
    plt.imshow(sub_image)
    plt.draw()
    plt.pause(.001)

def main():
    try:
        filename = sys.argv[1]
    except:
        print("Please enter a filename")
        return
    scan_image(filename)

if __name__ == "__main__":
    main()