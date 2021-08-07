package com.rex.retrofit_plugin.net

abstract class NetWorkLoader {
    companion object {
        private var instances: HashMap<String, NetWorkLoader> = HashMap()

        fun getInstance(baseUrl: String): NetWorkLoader {
            if (instances[baseUrl] == null) {
                instances[baseUrl] = DefaultServiceLocator(baseUrl)
            }
            return instances[baseUrl]!!
        }
    }

    abstract fun getRepository(): NetworkRepository
}

class DefaultServiceLocator(private val baseUrl: String) : NetWorkLoader() {

    private val api by lazy {
        RepositoryApi.getInstance(baseUrl)
    }

    override fun getRepository(): NetworkRepository {
        return NetworkRepository(api)
    }
}

