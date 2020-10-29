import numpy as np
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.model_selection import train_test_split
from auxiliar import transform_data


def get_dataset(precision="int32", sigmoid_decimal_bits=12, random_state=124):

    data_x, data_y = datasets.make_moons(n_samples=2 ** 11 + 256, shuffle=True, noise=0.20,
                                         random_state=random_state)

    X_train, X_test, y_train, y_test = train_test_split(data_x, data_y, train_size=2 ** 11,
                                                        test_size=256, random_state=random_state)
    y_train = y_train.reshape(-1, 1)
    y_test = y_test.reshape(-1, 1)

    print('X train max value: {:.2f}'.format(X_train.max()))
    print('X train min value: {:.2f}'.format(X_train.min()))

    X = transform_data(X_train.T, sigmoid_decimal_bits, precision)
    Y = transform_data(y_train.T, sigmoid_decimal_bits, precision)
    X_t = transform_data(X_test.T, sigmoid_decimal_bits, precision)
    Y_t = transform_data(y_test.T, sigmoid_decimal_bits, precision)

    print('X = {}'.format(X.flatten()))
    print('Y = {}'.format(Y.flatten()))

    check_color = np.vectorize((lambda y: 'red' if (y == 2 ** sigmoid_decimal_bits) else 'blue'))
    color = (check_color(Y).flatten()).tolist()

    plt.scatter(X.T[:, 0], X.T[:, 1], c=color)
    plt.show()

    return X, Y, X_t, Y_t
