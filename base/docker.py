import argparse
import subprocess


def main():
    parser = argparse.ArgumentParser(
        "make", description="helper script to build docker containers with a p2996 compiler")
    parser.add_argument("base")
    parser.add_argument("--tag", default=None)
    args = parser.parse_args()
    parent = args.base.split(':')[0]
    tag = args.tag or f"ghcr.io/rsl-org/{parent}_p2996"

    subprocess.check_call(["docker", "build", 
                           "--build-arg", f"BASE={args.base}", 
                           "--build-arg", f"PARENT={parent}", 
                           "--tag", tag, "."])


if __name__ == "__main__":
    main()
