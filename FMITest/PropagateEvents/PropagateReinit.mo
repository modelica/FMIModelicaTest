within FMITest.PropagateEvents;
package PropagateReinit
  "Test of two connected 1-dim. rotational inertias leading to a linear system of equations"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;

    Real x(start=0, fixed=true);
    Real y(start=-1, fixed=true);
    Real z(start=-1, fixed=true);
    Boolean ypos=y > 0;
    Boolean zpos=z > 0;
  equation
    der(x) = 0;
    der(y) = 0;
    der(z) = 1;

    when zpos then
      reinit(y, 1);
    end when;

    when {ypos,zpos} then
      reinit(x, if edge(ypos) then pre(x) + 1 else pre(x) + 2);
    end when;

    annotation (experiment(StopTime=2));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    FMUModels.Reinit_z reinit_z
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    FMUModels.Reinit_x reinit_x
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
  equation
    connect(reinit_z.ypos, reinit_x.ypos) annotation (Line(
        points={{-19,16},{-2,16}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(reinit_z.zpos, reinit_x.zpos) annotation (Line(
        points={{-19,4},{-2,4}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.Reinit_z reinit_z
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    FMUModels.Reinit_x reinit_x
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
  equation
    connect(reinit_z.ypos, reinit_x.ypos) annotation (Line(
        points={{-19,16},{-2,16}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(reinit_z.zpos, reinit_x.zpos) annotation (Line(
        points={{-19,4},{-2,4}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2.0));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model Reinit_z
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Real y(start=-1, fixed=true);
      Real z(start=-1, fixed=true);
      Modelica.Blocks.Interfaces.BooleanOutput ypos annotation (Placement(
            transformation(extent={{100,50},{120,70}}), iconTransformation(
              extent={{100,50},{120,70}})));
      Modelica.Blocks.Interfaces.BooleanOutput zpos annotation (Placement(
            transformation(extent={{100,-70},{120,-50}}), iconTransformation(
              extent={{100,-70},{120,-50}})));
    equation
      ypos = y > 0;
      zpos = z > 0;

      der(y) = 0;
      der(z) = 1;

      when zpos then
        reinit(y, 1);
      end when;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Text(
              extent={{-32,76},{84,46}},
              lineColor={0,0,0},
              textString="ypos",
              horizontalAlignment=TextAlignment.Right), Text(
              extent={{-28,-44},{88,-74}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Right,
              textString="zpos")}));
    end Reinit_z;

    model Reinit_x
      extends Modelica.Blocks.Interfaces.BlockIcon;

      Modelica.Blocks.Interfaces.BooleanInput ypos annotation (Placement(
            transformation(extent={{-140,40},{-100,80}}), iconTransformation(
              extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.BooleanInput zpos annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
              extent={{-140,-80},{-100,-40}})));

      Real x(start=0, fixed=true);
    equation
      der(x) = 0;
      when {ypos,zpos} then
        reinit(x, if edge(ypos) then pre(x) + 1 else pre(x) + 2);
      end when;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-84,80},{28,46}},
              lineColor={0,0,0},
              textString="ypos",
              horizontalAlignment=TextAlignment.Left), Text(
              extent={{-82,-42},{30,-76}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              textString="zpos")}));
    end Reinit_x;
  end FMUModels;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
This model tests whether events generated by one FMU are propagated to
another FMU and test at the same time whether the reinit-operator is mapped
correctly to an FMU. The reference solution computed in Dymola is:
</p>

<p>
<img src=\"modelica://FMITest/Resources/Images/PropagateReinit_result.png\">
</p>
</html>"));
end PropagateReinit;
