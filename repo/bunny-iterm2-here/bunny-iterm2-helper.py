import sys
import os
if len(sys.argv) == 4:
    helper = sys.argv[1]
    arg1 = sys.argv[2]
    arg2 = sys.argv[3]
    z_cmd = helper + ' \'ssh -t ' + arg1 + ' \\"cd ' + arg2 + ' && exec zsh -l\\"\''
    os.system(z_cmd)
else:
    helper = sys.argv[1]
    arg1 = sys.argv[2]
    z_cmd = helper + ' \'cd ' + arg1 + '\''
    os.system(z_cmd)

