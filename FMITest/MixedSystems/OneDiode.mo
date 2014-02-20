within FMITest.MixedSystems;
package OneDiode
  "Test of an electrical circuit with one ideal diode leading to a mixed system of equations"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=230, freqHz=50)
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-70,10})));
    Modelica.Electrical.Analog.Basic.Resistor R1(R=10)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Vknee=0.8)
      annotation (Placement(transformation(extent={{-28,20},{-8,40}})));
    Modelica.Electrical.Analog.Basic.Resistor R2(R=400) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={10,10})));
    Modelica.Electrical.Analog.Basic.Capacitor C(C=1e-4, v(start=0, fixed=true))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={32,10})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  equation
    connect(sineVoltage.p, R1.p) annotation (Line(
        points={{-70,20},{-70,30},{-60,30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(R1.n, idealDiode.p) annotation (Line(
        points={{-40,30},{-28,30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(idealDiode.n, R2.p) annotation (Line(
        points={{-8,30},{10,30},{10,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(R2.n, sineVoltage.n) annotation (Line(
        points={{10,0},{10,-10},{-70,-10},{-70,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(idealDiode.n, C.p) annotation (Line(
        points={{-8,30},{32,30},{32,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(C.n, sineVoltage.n) annotation (Line(
        points={{32,0},{32,-10},{-70,-10},{-70,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground.p, sineVoltage.n) annotation (Line(
        points={{10,-20},{10,-10},{-70,-10},{-70,0}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.1));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    FMUModels.HalfCircuitWithDiode halfCircuitWithDiode
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    FMUModels.HalfCircuitWithLoad halfCircuitWithLoad
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
  equation
    connect(halfCircuitWithLoad.v, halfCircuitWithDiode.v) annotation (Line(
        points={{-1,36},{-18,36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(halfCircuitWithDiode.i, halfCircuitWithLoad.i) annotation (Line(
        points={{-19,24},{-2,24}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.HalfCircuitWithDiode halfCircuitWithDiode
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    FMUModels.HalfCircuitWithLoad halfCircuitWithLoad
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
  equation
    connect(halfCircuitWithLoad.v, halfCircuitWithDiode.v) annotation (Line(
        points={{-1,36},{-18,36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(halfCircuitWithDiode.i, halfCircuitWithLoad.i) annotation (Line(
        points={{-19,24},{-2,24}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model HalfCircuitWithDiode
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=230, freqHz=
            50) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-60,20})));
      Modelica.Electrical.Analog.Basic.Resistor R1(R=10)
        annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Vknee=0.8)
        annotation (Placement(transformation(extent={{-18,30},{2,50}})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
      Utilities.PinToI pinToI
        annotation (Placement(transformation(extent={{12,36},{20,44}})));
      Modelica.Blocks.Interfaces.RealInput v
        "Potential at the pin as provided from the outside"
        annotation (Placement(transformation(extent={{140,40},{100,80}})));
      Modelica.Blocks.Interfaces.RealOutput i
        "Current flowing in to the pin as provided to the outside"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    equation

      connect(sineVoltage.p, R1.p) annotation (Line(
          points={{-60,30},{-60,40},{-50,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(R1.n, idealDiode.p) annotation (Line(
          points={{-30,40},{-18,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ground.p, sineVoltage.n) annotation (Line(
          points={{-60,-10},{-60,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealDiode.n, pinToI.pin) annotation (Line(
          points={{2,40},{12,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(pinToI.v, v) annotation (Line(
          points={{21.6,42},{55.8,42},{55.8,60},{120,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pinToI.i, i) annotation (Line(
          points={{20.8,38},{30,38},{30,38},{38,38},{38,-8},{92,-8},{92,-60},{
              110,-60}},
          color={0,0,127},
          smooth=Smooth.None));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-6,92},{84,48}},
                  lineColor={0,0,0},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="v",
                  horizontalAlignment=TextAlignment.Right),Text(
                  extent={{-12,-36},{78,-80}},
                  lineColor={0,0,0},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  horizontalAlignment=TextAlignment.Right,
                  textString="i"),Bitmap(extent={{-96,76},{46,-66}}, fileName=
              "modelica://FMITest/Resources/Images/HalfCircuitWithDiode.png"),
              Text(
                  extent={{-14,16},{94,-14}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end HalfCircuitWithDiode;

    model HalfCircuitWithLoad
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Electrical.Analog.Basic.Resistor R2(R=400) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={10,10})));
      Modelica.Electrical.Analog.Basic.Capacitor C(C=1e-4, v(start=0, fixed=
              true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={32,10})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
      Utilities.PinToV pinToV
        annotation (Placement(transformation(extent={{-44,26},{-52,34}})));
      Modelica.Blocks.Interfaces.RealInput i
        "Current flowing in to the pin as provided from the outside"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealOutput v
        "Potential at the pin as provided to the outside"
        annotation (Placement(transformation(extent={{-100,50},{-120,70}})));
    equation
      connect(R2.p, C.p) annotation (Line(
          points={{10,20},{10,30},{32,30},{32,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ground.p, R2.n) annotation (Line(
          points={{10,-20},{10,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ground.p, C.n) annotation (Line(
          points={{10,-20},{10,-10},{32,-10},{32,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(pinToV.pin, R2.p) annotation (Line(
          points={{-44,30},{10,30},{10,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(pinToV.i, i) annotation (Line(
          points={{-53.6,28},{-72,28},{-72,-60},{-120,-60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pinToV.v, v) annotation (Line(
          points={{-52.8,32},{-80,32},{-80,60},{-110,60}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        experiment(StopTime=0.1),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{-82,84},{8,40}},
                  lineColor={0,0,0},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  horizontalAlignment=TextAlignment.Left,
                  textString="v"),Text(
                  extent={{-80,-34},{10,-78}},
                  lineColor={0,0,0},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  horizontalAlignment=TextAlignment.Left,
                  textString="i"),Bitmap(extent={{-24,94},{94,-100}}, fileName=
              "modelica://FMITest/Resources/Images/HalfCircuitWithLoad.png"),
              Text(
                  extent={{-94,20},{0,-12}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end HalfCircuitWithLoad;
  end FMUModels;
  annotation (preferredView="Info");
end OneDiode;
