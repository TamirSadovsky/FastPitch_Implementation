import argparse

def remove_carriage_return(input_file, output_file):
    try:
        with open(input_file, 'r', newline='') as infile:
            with open(output_file, 'w', newline='') as outfile:
                for line in infile:
                    # Remove carriage return (\r) characters from each line
                    cleaned_line = line.replace('\r', '')
                    # Write cleaned line to output file
                    outfile.write(cleaned_line)
        print(f"Carriage return characters removed successfully. Output written to '{output_file}'.")
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found.")

if __name__ == '__main__':
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description='Convert text file to LF line endings.')
    parser.add_argument('input_file', metavar='INPUT_FILE', type=str, help='Path to input file')
    args = parser.parse_args()

    # Determine output file path
    output_file = args.input_file + '_cleaned'  # Output file will be named <input_file>_cleaned

    # Call remove_carriage_return function with specified file paths
    remove_carriage_return(args.input_file, output_file)
