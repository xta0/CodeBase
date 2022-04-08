from PIL import Image

import argparse

parser = argparse.ArgumentParser(description='')
parser.add_argument('--image', default="")
parser.add_argument('--out', default="./")
args = parser.parse_args()


def main():
    path = args.image
    im = Image.open(path)
    width, height = im.size
    print("image: (w:{0}, h{1})".format(width, height))
    size = (720*3, 1280)
    # x1, y1 = (width - w)/2, (height-h)/2
    # x2, y2 = x1+w
    im = im.resize(size)
    im.show()

if __name__ == "__main__":
    main()
    




