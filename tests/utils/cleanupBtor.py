import sys
import os


def cleanup(outname: str, filename: str):
    res: str = ""
    with open(filename, "r") as file:
        for line in file.readlines():
            if line[0].isnumeric():
                res += line + "\n"
    with open(outname, "w") as resfile:
        resfile.write(res)


if __name__ == "__main__":
    assert (
        len(sys.argv) > 2
    ), "Usage pyhton3 cleanupBtor.py <filename>.txt <outname>.btor2"
    cleanup(sys.argv[2], sys.argv[1])
