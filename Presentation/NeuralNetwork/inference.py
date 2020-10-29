from forward import linear_activation_forward


def inference(X, Y, parameters, sigma_int, k_shift, extra_bits, decimal_bits, precision):
    number_of_samples = X.shape[1]
    correct = 0
    incorrect = 0

    for i in range(number_of_samples):
        Xi = (X[:, i]).reshape(-1, 1)

        A1, cache1 = linear_activation_forward(Xi, parameters['W1'], parameters['b1'], activation='relu',
                                               k=k_shift, precision=precision)

        A2, cache2 = linear_activation_forward(A1, parameters['W2'], parameters['b2'], activation='relu',
                                               k=k_shift, precision=precision)

        AL, cache3 = linear_activation_forward(A2, parameters['W3'], parameters['b3'], activation='sigmoid',
                                               k=k_shift, table=sigma_int, extra_bits=extra_bits,
                                               sigmoid_decimal_bits=decimal_bits, precision=precision)

        predicted = [2**decimal_bits if (AL[0] > (2**decimal_bits)/ 2) == True else 0]

        if predicted[0] == Y[:, i][0]:
            correct = correct + 1
        else:
            incorrect = incorrect + 1

    accuracy = correct / number_of_samples

    return correct, incorrect, accuracy, AL
