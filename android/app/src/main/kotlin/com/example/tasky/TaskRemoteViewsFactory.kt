package com.example.tasky

import android.content.Context
import android.content.SharedPreferences
import android.util.Log
import android.widget.RemoteViews
import android.widget.RemoteViewsService

class TaskRemoteViewsFactory(private val context: Context) : RemoteViewsService.RemoteViewsFactory {
    private var tasks: List<String> = listOf()
    private val TAG = "TaskRemoteViewsFactory"

    override fun onCreate() {
        loadTasks()
    }

    override fun onDataSetChanged() {
        loadTasks()
    }

    private fun loadTasks() {
        val prefs: SharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val tasksString = prefs.getString("flutter.tasks", "")
        tasks = tasksString?.split(",")?.filter { it.isNotEmpty() } ?: emptyList()
    }

    override fun onDestroy() {
    }

    override fun getCount(): Int = tasks.size

    override fun getViewAt(position: Int): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.task_item)

        views.setTextViewText(R.id.task_text, tasks[position])

        val fillInIntent = android.content.Intent().apply {
            putExtra("task_text", tasks[position])
        }

        views.setOnClickFillInIntent(
            R.id.task_item_root,
            fillInIntent
        )

        return views
    }

    override fun getLoadingView(): RemoteViews? = null

    override fun getViewTypeCount(): Int = 1

    override fun getItemId(position: Int): Long = position.toLong()

    override fun hasStableIds(): Boolean = true
}