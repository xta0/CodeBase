# Gist

## Bayes Rule

- Bayes Rule
- Discrete / Continueous Probability
- Probability Distribution
    - Numpy, Scipy, Matplotlib
- Gaussian Distribution
    - Central Limit Theorm
- Localization

## Matrix

- Histogram
- Kalman Filter
    - Two Dimentional Gaussian
    - Contour plot
- Motion

### Kalman Filter Equations Fx versus Bu

Consider this specific Kalman filter equation: `x' = Fx + Bu`

This equation is the **move function（move函数）** that updates your beliefs in between sensor measurements. Fx models motion based on velocity, acceleration, angular velocity, etc of the object you are tracking.

B is called the control matrix and u is the control vector. Bu measures extra forces on the object you are tracking. An example would be if a robot was receiving direct commands to move in a specific direction, and you knew what those commands were and when they occurred. Like if you told your robot to move backwards 10 feet, you could model this with the Bu term.

When you take the self-driving car engineer nanodegree, you'll use Kalman filters to track objects that are moving around your vehicle like other cars, pedestrians, bicyclists, etc. In those cases, you would ignore BuBu because you do not have control over the movement of other objects. The Kalman filter equation becomes `x' = Fx`

