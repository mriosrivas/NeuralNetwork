import numpy as np
from parameters import initialize_parameters_deep
from tables import sigmoid_table, log_table, get_cross_entropy_tables
from dataset import get_dataset
from forward import linear_activation_forward
from backward import linear_activation_backward
from loss import cross_entropy_int, gradient_cross_entropy_int_table
from inference import inference

import matplotlib.pyplot as plt


if __name__ == '__main__':
    random_state = 124
    np.random.seed(random_state)

    EXTRA_BITS = 4
    DECIMAL_BITS = 12
    K_SHIFT = EXTRA_BITS + DECIMAL_BITS
    PRECISION = "int32"
    DOUBLE_PRECISION = "int32"

    # Create sigmoid table
    sigma_dec, sigma_int = sigmoid_table(EXTRA_BITS, DECIMAL_BITS, PRECISION)

    # Create log table
    z, log, log_int = log_table(DECIMAL_BITS, PRECISION)

    # Create gradient cross entropy table
    cross_entropy_table_1, cross_entropy_table_2 = get_cross_entropy_tables(DECIMAL_BITS, PRECISION)

    # Initialize parameters
    parameters = initialize_parameters_deep((2, 5, 5, 1), K_SHIFT, PRECISION)

    # Get training and test data from moons dataset
    X, Y, X_t, Y_t = get_dataset(PRECISION, DECIMAL_BITS, random_state)

    # Training
    # Auxiliary variables to keep track of cost
    accumulate_cost = 0
    total_cost = []
    accumulate_epoch_inference = []
    acc_dAL = 0

    # Hyperparameters
    learning_rate = 8 # Bigger numbers small increment on gradient
    epochs = 10

    number_of_samples = X.shape[1]
    average_factor = int(np.log(number_of_samples) / np.log(2))

    for j in range(epochs):
        for i in range(number_of_samples):

            # Forward pass
            Xi = (X[:, i]).reshape(-1, 1)

            A1, cache1 = linear_activation_forward(Xi, parameters['W1'], parameters['b1'], activation='relu',
                                                   k=K_SHIFT, precision=PRECISION)

            A2, cache2 = linear_activation_forward(A1, parameters['W2'], parameters['b2'], activation='relu',
                                                   k=K_SHIFT, precision=PRECISION)

            AL, cache3 = linear_activation_forward(A2, parameters['W3'], parameters['b3'], activation='sigmoid',
                                                   k=K_SHIFT, table=sigma_int, extra_bits=EXTRA_BITS,
                                                   sigmoid_decimal_bits=DECIMAL_BITS, precision=PRECISION)

            # Compute cost
            cost = cross_entropy_int(int(AL[0][0]), Y[0][i], log_int, DECIMAL_BITS, DOUBLE_PRECISION)
            accumulate_cost = (accumulate_cost + cost).astype(DOUBLE_PRECISION)

            # Gradient of cost with respect of AL
            dAL = gradient_cross_entropy_int_table(int(AL), int(Y[0][i]), cross_entropy_table_1,
                                                   cross_entropy_table_2, DECIMAL_BITS, PRECISION)
            acc_dAL = (acc_dAL + dAL).astype(PRECISION)

            # Backward pass
            if i == number_of_samples - 1:
                dAL = (acc_dAL >> average_factor).astype(PRECISION)
                acc_dAL = 0

                dA2, dW3, db3 = linear_activation_backward(dAL, cache3, activation='sigmoid',
                                                           sigmoid_decimal_bits=DECIMAL_BITS,
                                                           precision=PRECISION, table=sigma_int)

                dA1, dW2, db2 = linear_activation_backward(dA2, cache2, activation='relu',
                                                           sigmoid_decimal_bits=DECIMAL_BITS,
                                                           precision=PRECISION)

                dA0, dW1, db1 = linear_activation_backward(dA1, cache1, activation='relu',
                                                           sigmoid_decimal_bits=DECIMAL_BITS,
                                                           precision=PRECISION)

                # Update
                parameters['W1'] = parameters['W1'] - np.right_shift(dW1, learning_rate)
                parameters['b1'] = parameters['b1'] - np.right_shift(db1, learning_rate)
                parameters['W2'] = parameters['W2'] - np.right_shift(dW2, learning_rate)
                parameters['b2'] = parameters['b2'] - np.right_shift(db2, learning_rate)
                parameters['W3'] = parameters['W3'] - np.right_shift(dW3, learning_rate)
                parameters['b3'] = parameters['b3'] - np.right_shift(db3, learning_rate)

                # Compute cost
                cost = cross_entropy_int(int(AL[0][0]), Y[0][i], log_int, DECIMAL_BITS, DOUBLE_PRECISION)
                accumulate_cost = (accumulate_cost + cost).astype(DOUBLE_PRECISION)

        # Test results on every iteration
        correct, incorrect, epoch_inference, AL = inference(X, Y, parameters, sigma_int, K_SHIFT,
                                                            EXTRA_BITS, DECIMAL_BITS, PRECISION)
        accumulate_epoch_inference.append(epoch_inference)

        # Calculate cost on every iteration
        epoch_cost = accumulate_cost / number_of_samples
        total_cost.append(epoch_cost)
        print('epoch = {}, total cost = {:.2f}'.format(j + 1, epoch_cost))

        accumulate_cost = 0

    # Error analysis
    error = 1 - np.array(accumulate_epoch_inference)
    print('\nTraining information: ')
    print('Min Error = {:.2f}%'.format(100 * error.min()))
    print('Max Error = {:.2f}%'.format(100 * error.max()))

    plt.plot(error * 100)
    plt.title("Error vs Training Epochs")
    plt.xlabel("Epoch")
    plt.ylabel("Error")
    plt.grid("on")

    # Test inference on training data
    correct, incorrect, epoch_inference, AL = inference(X, Y, parameters, sigma_int, K_SHIFT,
                                                        EXTRA_BITS, DECIMAL_BITS, PRECISION)
    error = 1 - np.array(epoch_inference)
    print('\nInference on training data: ')
    print('Error = {:.2f}%'.format(100 * error))

    # Test inference on test data
    correct, incorrect, epoch_inference, AL = inference(X_t, Y_t, parameters, sigma_int, K_SHIFT,
                                                        EXTRA_BITS, DECIMAL_BITS, PRECISION)
    error = 1 - np.array(epoch_inference)
    print('\nInference on test data: ')
    print('Error = {:.2f}%'.format(100 * error))

    plt.show()

print("Done!")