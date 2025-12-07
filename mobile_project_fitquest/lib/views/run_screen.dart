import 'package:flutter/material.dart';
import 'dart:async';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  Timer? _timer;
  int _seconds = 0;
  double _distance = 0.0;
  bool _isRunning = false;
  List<Map<String, dynamic>> _runHistory = [];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startRun() {
    if (!_isRunning) {
      setState(() {
        _isRunning = true;
        _seconds = 0;
        _distance = 0.0;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
          // Simulate distance - in real app, this would come from GPS
          _distance += 0.00278; // Approx 10 km/h speed
        });
      });
    }
  }

  void _stopRun() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      
      // Save the run
      _runHistory.add({
        'date': DateTime.now(),
        'duration': _seconds,
        'distance': _distance,
        'pace': _seconds / (_distance * 60),
      });
    });
  }

  void _resetRun() {
    setState(() {
      _isRunning = false;
      _seconds = 0;
      _distance = 0.0;
      _timer?.cancel();
    });
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Run Tracker'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Stats Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard('TIME', _formatTime(_seconds), Icons.timer),
                        _buildStatCard('DISTANCE', '${_distance.toStringAsFixed(2)} km', Icons.directions_run),
                        _buildStatCard('PACE', _distance > 0 ? '${(_seconds / (_distance * 60)).toStringAsFixed(2)} min/km' : '0:00', Icons.speed),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Control Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildControlButton(
                          icon: _isRunning ? Icons.pause : Icons.play_arrow,
                          label: _isRunning ? 'PAUSE' : 'START',
                          color: _isRunning ? Colors.orange : Colors.green,
                          onPressed: _isRunning ? null : _startRun,
                        ),
                        const SizedBox(width: 16),
                        _buildControlButton(
                          icon: Icons.stop,
                          label: 'STOP',
                          color: Colors.red,
                          onPressed: _isRunning ? _stopRun : null,
                        ),
                        const SizedBox(width: 16),
                        _buildControlButton(
                          icon: Icons.refresh,
                          label: 'RESET',
                          color: Colors.blueGrey,
                          onPressed: _resetRun,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Map Placeholder
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, size: 60, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        'Live Run Tracking',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('Map will display your route here'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Run History
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Runs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            if (_runHistory.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.directions_run, size: 60, color: Colors.grey[400]),
                      const SizedBox(height: 10),
                      const Text(
                        'No runs recorded yet',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Text('Start your first run above!'),
                    ],
                  ),
                ),
              )
            else
              ..._runHistory.reversed.map((run) => _buildRunHistoryItem(run)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.purple),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: onPressed,
            iconSize: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildRunHistoryItem(Map<String, dynamic> run) {
    final date = run['date'] as DateTime;
    final duration = run['duration'] as int;
    final distance = run['distance'] as double;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.directions_run, color: Colors.purple),
        title: Text('${distance.toStringAsFixed(2)} km Run'),
        subtitle: Text(
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} • '
          '${_formatTime(duration)} • '
          '${(duration / (distance * 60)).toStringAsFixed(2)} min/km',
        ),
        trailing: Text(
          '${date.day}/${date.month}',
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}