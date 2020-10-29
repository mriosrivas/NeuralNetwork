import sys
import numpy as np
import pandas as pd


def verilog_if_module_generate(file_name, module_name, out_name, in_name,
                               table, out_bit_size, in_bit_size, else_condition):
    """
    Function to generate a table lookup using if clauses.

    :param file_name: name of verilog file
    :param module_name: name of module
    :param out_name: name of output port
    :param in_name: name of input port
    :param table: table to create a verilog implementation
    :param out_bit_size: number of bits for the output port
    :param in_bit_size: number of bits for the input port
    :param else_condition: else condition to be added
    :return: None
    """
    original_stdout = sys.stdout  # Save a reference to the original standard output

    df = pd.DataFrame(np.arange(table.shape[0]), columns=["input"])
    df["output"] = pd.DataFrame(table.reshape(-1, 1))
    data = df.groupby("output").indices
    keys = data.keys()

    with open(file_name, 'w') as f:
        sys.stdout = f  # Change the standard output to the file we created.

        print("module {}(input logic [{}:0] {},".format(module_name, in_bit_size - 1, in_name))
        print("\t output logic [{}:0] {});".format(out_bit_size - 1, out_name))
        print("\t \t always_comb")

        for idx, k in enumerate(keys):
            if (idx == 0):
                print('\t \t \t if (in >= {} && in <= {}) out = {};'.format(data[k].min(), data[k].max(), k))
            else:
                print('\t \t \t else if (in >= {} && in <= {}) out = {};'.format(data[k].min(), data[k].max(), k))
        print("\t \t \telse out={};".format(else_condition))
        print("\t endmodule")

        sys.stdout = original_stdout  # Reset the standard output to its original value

    return


def verilog_case_module_generate(file_name, module_name, out_name, in_name,
                                 table, out_bit_size, in_bit_size, default_condition):
    """
    Function to generate a table lookup using case statement.

    :param file_name: name of verilog file
    :param module_name: name of module
    :param out_name: name of output port
    :param in_name: name of input port
    :param table: table to create a verilog implementation
    :param out_bit_size: number of bits for the output port
    :param in_bit_size: number of bits for the input port
    :param default_condition: default condition to be added
    :return: None
    """
    original_stdout = sys.stdout  # Save a reference to the original standard output

    df = pd.DataFrame(np.arange(table.shape[0]), columns=["input"])
    df["output"] = pd.DataFrame(table.reshape(-1, 1))
    data = df.groupby("output").indices
    keys = data.keys()

    with open(file_name, 'w') as f:
        sys.stdout = f  # Change the standard output to the file we created.

        print("module {}(input logic [{}:0] {},".format(module_name, in_bit_size - 1, in_name))
        print("\t output logic [{}:0] {});".format(out_bit_size - 1, out_name))
        print("\t \t always_comb")
        print("\t \t \t case()".format(in_name))

        for idx, k in enumerate(keys):
            print('\t \t \t {}  : out <= {};'.format(data[k][0], k))

        print("\t \t \t default : out <= {};".format(default_condition))
        print("\t \t endcase")
        print("\t endmodule")

        sys.stdout = original_stdout  # Reset the standard output to its original value
    return