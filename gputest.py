import time
import os
import subprocess
from mujoco_py import load_model_from_xml, MjSim, MjViewer

MODEL_XML = """
<?xml version="1.0" ?>
<mujoco>
    <worldbody>
        <body name="box" pos="0 0 0.2">
            <geom size="0.15 0.15 0.15" type="box"/>
            <joint axis="1 0 0" name="box:x" type="slide"/>
            <joint axis="0 1 0" name="box:y" type="slide"/>
        </body>
        <body name="floor" pos="0 0 0.025">
            <geom size="1.0 1.0 0.02" rgba="0 1 0 1" type="box"/>
        </body>
    </worldbody>
</mujoco>
"""

model = load_model_from_xml(MODEL_XML)
sim = MjSim(model)
step = 0
while step < 10:
    t = time.time()
    sim.render(width=256, height=256, device_id=0)
    print(time.time()-t)
    step += 1
subprocess.call('nvidia-smi', shell=True)
print(f"PID={os.getpid()}")