import math

def make_qp():
    steps = 4
    stepsize = 1 / (steps + 1) * 3.14159 / 2
    volumes = []
    for i in range(1,steps + 1):
        angle = i * stepsize
        y = math.cos(angle)
        x = math.sin(angle)
        v = ["-0.5,0,0,-1,0,0","0,0,-0.5,0,0,-1","0,0,0.5,0,0,1","0,1,0,0,1,0","0,0,0,0,-1,0"]
        #v += {pt = {0.49 - x * 0.97, (1-y) * 0.99, 0}, normal = v_norm({x, y, 0})})
        d = math.sqrt(x * x + y * y)
        nx = x / d
        ny = y / d
        v.append("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f" % (0.49 - x * 0.97, (1-y) * 0.99, 0, nx, ny, 0))
        volumes.append(v)
    return volumes

def make_barrier():
    steps = 1
    stepsize = 1 / (steps + 1) * 3.14159 * 0.5
    volumes = []
    for i in range(1,steps + 2):
        angle = i * stepsize
        y = math.cos(angle)
        x = math.sin(angle)
        v = ["0,0,-0.5,0,0,-1","0,0,0.5,0,0,1","0,0,0,0,-1,0", "0,0.5,0,0,1,0"]
        #v += {pt = {0.49 - x * 0.97, (1-y) * 0.99, 0}, normal = v_norm({x, y, 0})})
        d = math.sqrt(x * x + y * y)
        nx = x / d
        ny = y / d
        v.append("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f" % (0.5 - x * 0.125, (1-y) * 0.125, 0, nx, ny, 0))
        v.append("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f" % (-0.5 + x * 0.125, (1-y) * 0.125, 0, -nx, ny, 0))
        volumes.append(v)
    return volumes

def make_barrier2():
    steps = 2
    stepsize = 1 / (steps + 1) * 3.14159 / 2
    volumes = []
    for i in range(1,steps + 1):
        angle = i * stepsize
        y = math.cos(angle)
        x = math.sin(angle)
        v = ["-0.5,0,0,-1,0,0","0,0,-0.5,0,0,-1","0,0,0.5,0,0,1","0,0.5,0,0,1,0","0,0,0,0,-1,0"]
        #v += {pt = {0.49 - x * 0.97, (1-y) * 0.99, 0}, normal = v_norm({x, y, 0})})
        d = math.sqrt(x * x + y * y)
        nx = x / d
        ny = y / d
        v.append("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f" % (- x * 0.47, (1-y) * 0.49, 0, nx, ny, 0))
        volumes.append(v)
    return volumes

if __name__ == "__main__":
    volumes = make_barrier2()
    print("/".join(";".join(volume) for volume in volumes))