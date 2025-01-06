$$
x +^{u}_{w} y = 
\begin{array}{rcl}
 & x + y &\text{for} & x + y < 2^{w} & \text{Normal}\\
 & x + y - 2^{w}&\text{for} & 2^{w}\leq x + y \leq 2^{w+1} & \text{Overflow}
\end{array}
$$


---

$$
\begin{align}
 x +^{t}_{w} y = U 2 T_{w} (T 2 U_{w}(x) +^{u}_{w} T 2 U_{w}(y)) \\ \\
= U 2 T_{w}[(x_{w-1}2^{w}+x + y_{w-1}2^{w}+y)\text{mod}2^w]\\ \\
= U 2 T_{w}[(x + y)\text{mod}2^w]
\end{align}
$$


---

