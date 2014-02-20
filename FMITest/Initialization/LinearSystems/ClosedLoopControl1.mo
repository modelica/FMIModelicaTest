within FMITest.Initialization.LinearSystems;
package ClosedLoopControl1
  "Closed loop control without direct feedthrough but steady state initialization. This leads to a linear system of equations over FMUs during initialization and to an artificial loop during simulation"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Continuous.TransferFunction plant(
      b={0.1,1},
      a={0.02,0.26,1},
      initType=Modelica.Blocks.Types.Init.SteadyState)
      annotation (Placement(transformation(extent={{40,0},{60,20}})));
    Modelica.Blocks.Continuous.PI PI(
      T=0.1,
      k=10,
      initType=Modelica.Blocks.Types.Init.SteadyState)
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Sources.Step step(offset=0.5, startTime=0.5)
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  equation
    connect(PI.y, plant.u) annotation (Line(
        points={{21,10},{38,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback.y, PI.u) annotation (Line(
        points={{-21,10},{-2,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(plant.y, feedback.u2) annotation (Line(
        points={{61,10},{74,10},{74,-20},{-30,-20},{-30,2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, feedback.u1) annotation (Line(
        points={{-59,10},{-38,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    FMUModels.Plant1 plant
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    FMUModels.Controller1 controller
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.Step step(offset=0.5, startTime=0.5)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation
    connect(controller.y, plant.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, controller.u_s) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(plant.y, controller.u_m) annotation (Line(
        points={{41,10},{52,10},{52,-18},{-10,-18},{-10,-2}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    FMUModels.Plant1 plant
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    FMUModels.Controller1 controller
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.Step step(offset=0.5, startTime=0.5)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation
    connect(controller.y, plant.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, controller.u_s) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(plant.y, controller.u_m) annotation (Line(
        points={{41,10},{52,10},{52,-18},{-10,-18},{-10,-2}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model Plant1
      extends Modelica.Blocks.Interfaces.SISO;
      Modelica.Blocks.Continuous.TransferFunction plant(
        b={0.1,1},
        a={0.02,0.26,1},
        initType=Modelica.Blocks.Types.Init.SteadyState)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(plant.u, u) annotation (Line(
          points={{-12,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(plant.y, y) annotation (Line(
          points={{11,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-84,-66},{84,-98}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Bitmap(extent={{-98,90},{98,-62}},
              fileName="modelica://FMITest/Resources/Images/Plant1.png")}));
    end Plant1;

    model Controller1
      extends Modelica.Blocks.Interfaces.SVcontrol;
      Modelica.Blocks.Continuous.PI PI(
        T=0.1,
        k=10,
        initType=Modelica.Blocks.Types.Init.SteadyState)
        annotation (Placement(transformation(extent={{24,-10},{44,10}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(feedback.y, PI.u) annotation (Line(
          points={{9,0},{22,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(feedback.u1, u_s) annotation (Line(
          points={{-8,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(feedback.u2, u_m) annotation (Line(
          points={{0,-8},{0,-120}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(PI.y, y) annotation (Line(
          points={{45,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-84,-62},{84,-94}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Bitmap(extent={{-90,88},{94,-56}},
              fileName="modelica://FMITest/Resources/Images/Controller1.png")}));
    end Controller1;
  end FMUModels;
  annotation (preferredView="Info");
end ClosedLoopControl1;
