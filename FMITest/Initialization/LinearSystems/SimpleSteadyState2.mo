within FMITest.Initialization.LinearSystems;
package SimpleSteadyState2
  "Simple steady state initialization of a PI controller as FMU leading to a linear system of equations over FMUs during initialization"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    parameter Real x0(start=0,fixed=false);
    FMUModels.PI PI1(x(start=x0))
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    Modelica.Blocks.Sources.Step step(startTime=0.1, offset=0.2)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Math.Gain gain(k=2)
      annotation (Placement(transformation(extent={{20,40},{40,60}})));
  initial equation
    PI1.residue = 0.0;
  equation

    connect(step.y, PI1.u1) annotation (Line(
        points={{-59,50},{-40,50},{-40,56},{-22,56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(PI1.y, gain.u) annotation (Line(
        points={{1,50},{18,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, PI1.u2) annotation (Line(
        points={{41,50},{52,50},{52,20},{-32,20},{-32,44},{-22,44}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    parameter Real x0(start=0,fixed=false);
    FMUModels.PI PI1(x(start=x0))
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    Modelica.Blocks.Sources.Step step(startTime=0.1, offset=0.2)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Math.Gain gain(k=2)
      annotation (Placement(transformation(extent={{20,40},{40,60}})));
  initial equation
    PI1.residue = 0.0;
  equation

    connect(step.y, PI1.u1) annotation (Line(
        points={{-59,50},{-40,50},{-40,56},{-22,56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(PI1.y, gain.u) annotation (Line(
        points={{1,50},{18,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, PI1.u2) annotation (Line(
        points={{41,50},{52,50},{52,20},{-32,20},{-32,44},{-22,44}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1),
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model PI
      extends Modelica.Blocks.Interfaces.SI2SO;
      parameter Real k=1.0;
      parameter Real T=0.1;
      parameter Real residue(final fixed=false, start=0.0);
      Real x(final fixed=true, start=0.0);
      Real e;
    equation
      e = u1 - u2;
      der(x) = e/T;
      y = k*(x + e);
    initial equation
      der(x) = residue;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
              extent={{-78,-52},{78,-80}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"), Text(
              extent={{-82,62},{74,34}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="PI
")}));
    end PI;

  end FMUModels;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
With this test model it is tested how the initialization of an FMU
can be changed in the environment where this FMU is used. The FMU is a PI controller
that is initialized in steady state which in turn leads to a constraint on the inputs.
However, this cannot be directly formulated as FMU. The implementation is performed 
in the following way:
</p>

<ol>
<li> In order that the causality of the FMU of the input signals does not
     change during initialization, a dependent parameter \"residue\" with
     initialization fixed = false is introduced. In case the inputs follow
     the constraint of the PI initialization, residue is computed to zero
     (as it should be). </li>
<li> The FMU initialization is not yet complete, since the PI state is not
     defined during initialization. Therefore, the PI state is initialized.</li>
<li> When used in the environment without special handling, the PI-controller
     is initialized so that PI.x has the given start value and the parameter
     residue = u1 - u2. To formulate the desired steady-state condition,
     the initial value of the PI state is associated with n parameter x0 with
     fixed = false (so this parameter is computed). 
     Now, one initial condition is missing and it is introduced by adding the
     initial equation \"residue = 0\". Note, when generating the FMU, parameter PI.residue
     should have \"causality = output\" and \"variability = fixed\" (since public, dependent
     parameter).<li>
</ol>

</html>"));
end SimpleSteadyState2;
