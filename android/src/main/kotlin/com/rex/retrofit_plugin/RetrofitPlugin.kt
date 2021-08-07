package com.rex.retrofit_plugin

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StandardMessageCodec

/** RetrofitPlugin */
class RetrofitPlugin : FlutterPlugin, BasicMessageChannel.MessageHandler<Any> {

    companion object {
        const val MESSAGE_CHANNEL_PATH = "retrofitRequest"
        var TIME_OUT = 10
    }

    private lateinit var messageChannel: BasicMessageChannel<Any>
    private val mRequestLoader = RequestLoader()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        initTimeOut(flutterPluginBinding.applicationContext)
        messageChannel = BasicMessageChannel(
            flutterPluginBinding.binaryMessenger,
            MESSAGE_CHANNEL_PATH,
            StandardMessageCodec()
        )
        messageChannel.setMessageHandler(this)
    }

    private fun initTimeOut(context: Context) {
        //读取res配置中的超时配置
        TIME_OUT = context.resources.getInteger(R.integer.timeOut)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        //暂无处理
    }

    override fun onMessage(
        message: Any?,
        reply: BasicMessageChannel.Reply<Any>
    ) {
        message?.let {
            val mapParams = it as Map<String, Any>
            val method = mapParams["method"] as String
            val baseUrl = mapParams["baseUrl"] as String
            val pathUrl = mapParams["pathUrl"] as String
            val headers = mapParams["headers"]
            val params = mapParams["params"]
            doRequest(
                method = method,
                baseUrl = baseUrl,
                pathUrl = pathUrl,
                headers = headers as Map<String, String>,
                params = params as Map<String, Any>,
                reply = reply
            )
        }
    }

    private fun doRequest(
        method: String,
        baseUrl: String,
        pathUrl: String,
        headers: Map<String, String>,
        params: Map<String, Any>,
        reply: BasicMessageChannel.Reply<Any>
    ) {
        mRequestLoader.doRequest(
            method,
            baseUrl,
            pathUrl,
            headers,
            params,
            object : IRequestResult {
                override fun onSuccess(data: String) {
                    reply.reply(createResult(true, data))
                }

                override fun onError(msg: String) {
                    reply.reply(createResult(false, msg))
                }
            })
    }

    private fun createResult(success: Boolean, data: String): HashMap<String, Any> {
        var result = HashMap<String, Any>()
        result["success"] = success
        result["data"] = data
        return result
    }

}
