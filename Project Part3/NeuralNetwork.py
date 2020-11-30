__author__ = "Divesh Badod"

import keras
import matplotlib.pyplot as plt
from keras import layers
from pandas import read_csv
import time
import memory_profiler

"""
Reading the prepared dataset and dividing it into training and testing dataset
"""
dataset = read_csv("dataset2.csv", header=0, delimiter=",")
X_train = dataset.sample(frac=0.7, random_state=0)
X_test = dataset.drop(X_train.index)
Y_train = X_train.pop('Total Security Rating')
Y_test = X_test.pop('Total Security Rating')


def build_model():
    """
    A neural network model is built with the specified number of neurons in the hidden layer
    an activation function, loss function and an optimizer.
    :return: model
    """
    model = keras.Sequential([layers.Dense(5, activation='sigmoid', input_shape=[len(X_train.keys())]),
                              layers.Dense(1, activation='sigmoid')])
    model.compile(loss='mean_squared_error', optimizer='adam', metrics=['mean_absolute_error', 'mean_squared_error'])
    return model


def plot_history_error(history):
    """
    Plotting the mean absolute error graphs
    :param history:
    :return:
    """
    plt.plot(history.history['mean_absolute_error'])
    plt.plot(history.history['val_mean_absolute_error'])
    plt.title('Mean Absolute Error')
    plt.ylabel('Mean Absolute Error')
    plt.xlabel('epochs')
    plt.legend(['train', 'test'], loc='upper left')
    plt.show()


def plot_history_squared_error(history):
    """
    Plotting the Mean squared error graphs
    :param history:
    :return:
    """
    plt.plot(history.history['mean_squared_error'])
    plt.plot(history.history['val_mean_squared_error'])
    plt.title('Mean Squared Error')
    plt.ylabel('Mean Squared Error')
    plt.xlabel('epochs')
    plt.legend(['train', 'test'], loc='upper left')
    plt.show()


@memory_profiler.profile
def main():
    start_time = time.time()
    model = build_model()
    # Here the model is trained using a certain number of epoch and validation splits
    history = model.fit(X_train, Y_train, epochs=100, validation_split=0.3, verbose=False)
    # print(history.history.keys())
    plot_history_error(history)
    plot_history_squared_error(history)
    # The model predicts the value for the given testing dataset
    test_predictions = model.predict(X_test).flatten()
    # print(test_predictions)
    # The model's loss mean absolute error is evaluated and stored in the variables
    loss, ae, se = model.evaluate(X_test, Y_test, verbose=0)
    print("Mean Abs Error after testing:" + str(ae))
    print("Mean Squared Error after testing:" + str(se))
    print("Time Taken:" + str((time.time() - start_time)))
    # Scatter plot graph is plotted to show the relationship between the predicted set and the actual set
    plt.scatter(Y_test, test_predictions)
    plt.xlabel('True Values')
    plt.ylabel('Predictions')
    plt.plot([Y_test.min(), Y_test.max()], [Y_test.min(), Y_test.max()], 'k--', lw=4)
    plt.show()


if __name__ == '__main__':
    main()
