import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np

image = mpimg.imread('champaign_south.jp2')
height = image.shape[0]
width = image.shape[1]
h_count = height // 300
w_count = width // 300
plt.ion()
plt.show()

count = 0
# Iterate through 300x300 map squares
for i in range(h_count):
    for j in range(w_count):
        h_start = 300 * i
        h_end = min(300 * (i+1), height)
        w_start = 300 * j
        w_end = min(300 * (j+1), width)
        sub_image = np.copy(image[h_start:h_end,w_start:w_end,:])
        sub_image[:,:,3] = 255
        plt.imshow(sub_image)
        plt.draw()
        plt.pause(.001)
        response = input("Does this contain a basketball court? (y/n) ")
        if response == 'y':
            plt.imsave('images/training/court-{}'.format(count), sub_image)
        plt.clf()
        count += 1