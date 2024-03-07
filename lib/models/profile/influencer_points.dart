class InfluencerPoints {
  final String id;
  final int campaignsCompleted;
  final int totalPoints;
  final List<String> completedTasks;
  InfluencerPoints({
    required this.id,
    required this.campaignsCompleted,
    required this.totalPoints,
    required this.completedTasks,
  });

  factory InfluencerPoints.fromMap(Map<String, dynamic> map) {
    return InfluencerPoints(
      id: map['_id'] ?? '',
      campaignsCompleted: map['campaigns_completed']?.toInt() ?? 0,
      totalPoints: map['total_points']?.toInt() ?? 0,
      completedTasks: List<String>.from(map['completed_tasks']),
    );
  }

  @override
  String toString() {
    return 'InfluencerPoints(id: $id, campaignsCompleted: $campaignsCompleted, totalPoints: $totalPoints, completedTasks: $completedTasks)';
  }
}
