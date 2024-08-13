import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import binom, geom, nbinom, poisson


# Parameters: -- INSERT DISTRIBUTION --
# -------------------------------------
p1 = 0.75
p2 = 0.25

n1 = 20
n2 = 20

x1 = np.arange(n1 + 1)
x2 = np.arange(n1 + 1)

pmf_x1 = binom.pmf(x1, n1, p1)
pmf_x2 = binom.pmf(x2, n2, p2)


# Cartesian plane setup
# ---------------------
fig, ax = plt.subplots(figsize=(9.5, 4.5))

ax.set_title('GRAPH TITLE')

ax.set_xlabel('LABEL: X-AXIS')
ax.set_xticks(np.arange(0, 26, 5))
ax.set_xticks(np.arange(0, 26), minor=True)
ax.set_xlim(-1, 21)

ax.set_ylabel('LABEL: Y-AXIS')


# Plot data
# ---------
ax.plot(x1, pmf_x1, marker='o', linestyle=':', color='red',   alpha=0.6,
        label=r'$X_1\sim\mathrm{Binom}(n=20, p=0.75)$')
ax.plot(x2, pmf_x2, marker='o', linestyle=':', color='green', alpha=0.6,
        label=r'$X_2\sim\mathrm{Binom}(n=20, p=0.75)$')


# Render
# ------
ax.grid()
ax.legend()

plt.show()

