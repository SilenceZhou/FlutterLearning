import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc.dart';

/// 现在我们需要创建我们的设置小部件，用户可以从中切换单位。(华氏度还是摄氏度)
///
class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ///
          /// 我们使用BlocProvider通过BuildContext访问SettingsBloc，
          /// 然后使用BlocBuilder重建基于SettingsState更改的UI。
          ///
          /// 我们的UI包含一个带有单个ListTile的ListView，
          /// 其中包含一个用户可以切换以选择摄氏度与华氏度的开关。
          ///
          /// 在switch的onChanged方法中，我们调度一个TemperatureUnitsToggled事件
          /// 来通知SettingsBloc温度单位已经改变。
          ///
          /// 接下来，我们需要允许用户从我们的Weather小部件进入Settings小部件
          /// 我们可以通过在AppBar中添加一个新的IconButton来实现。
          BlocBuilder(
            bloc: settings,
            builder: (BuildContext context, SettingsState state) {
              return ListTile(
                title: Text('Temperature Units'),
                isThreeLine: true,
                subtitle:
                    Text('Use metric measurements for temperature units.'),
                trailing: Switch(
                  value: state.temperatureUnits == TemperatureUnits.celsius,
                  onChanged: (_) {
                    settings.dispatch(TemperatureUnitsToggled());
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
