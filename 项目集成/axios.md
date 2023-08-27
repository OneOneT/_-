# 01_常见请求演练.js

```js
const axios = require("axios");

// 1.发送request请求
// axios
//   .request({
//     url: "http://httpbin.org/get",
//     method: "get",
//   })
//   .then((res) => {
//     console.log(res.data);
//   });

// 2.发送get请求
// axios.get("http://httpbin.org/get").then((res) => {
//   console.log("res", res.data);
// });

// axios
//   .get("http://httpbin.org/get", {
//     params: {
//       Id: 123,
//     },
//   })w
//   .then((res) => {
//     console.log(res.data);
//   });

// 3.发送post请求
// axios
//   .post("http://httpbin.org/post", {
//     name: "pyy",
//     age: 19,
//   })
//   .then((res) => {
//     console.log(res.data);
//   });

axios
  .post("http://httpbin.org/post", {
    data: {
      name: "pyy",
      age: 19,
    },
  })
  .then((res) => {
    console.log(res.data);
  });

```

# 02_额外知识补充.js

```js
const axios = require("axios").default;

// 1.baseURL
const baseURL = "http://httpbin.org";

// 给axios实例配置公共的基础配置

axios.defaults.baseURL = baseURL;
axios.defaults.timeout = 10000;

// axios.get("/get").then((res) => {
//   console.log("res:", res.data);
// });

// 2.axios发送多个请求
// Promise.all
axios.all([axios.get("/get"), axios.get("/get")]).then((res) => {
  console.log(res);
});

```

# 03_创建axios实例.js

```js
const axios = require("axios").default;
// axios默认库提供给我们的实例对象
// axios.get("https://httpbin.org/get").then((res) => {
//   console.log(res.data);
// });

// 创建其他的实例发送网络请求
const instance = axios.create({
  baseURL: "https://httpbin.org",
  timeout: 10000,
});

instance.get("/get").then((res) => {
  console.log(res.data);
});

```



# 04_Axios的拦截器.js

```js

// 对实例配置拦截器
axios.interceptors.request.use((config) => {
  console.log("请求成功的拦截")
  // 1.开始loading的动画

  // 2.对原来的配置进行一些修改
  // 2.1. header
  // 2.2. 认证登录: token/cookie
  // 2.3. 请求参数进行某些转化

  return config
}, (err) => {
  console.log("请求失败的拦截")
  return err
})

axios.interceptors.response.use((res) => {
  console.log("响应成功的拦截")

  // 1.结束loading的动画

  // 2.对数据进行转化, 再返回数据
  return res.data
}, (err) => {
  console.log("响应失败的拦截:", err)
  return err
})

axios.get("http://123.207.32.32:9001/lyric?id=500665346").then(res => {
  console.log("res:", res)
}).catch(err => {
  console.log("err:", err)
})
```

# 05. axios-js(封装)

```js
const axios = require("axios").default; //CommonJS 用法

class MyAxios {
  constructor(baseURL, timeout = 10000) {
    this.instance = axios.create({
      baseURL,
      timeout,
    });

    // 请求拦截
    this.instance.interceptors.request.use((config) => {
      return config;
    });

    // 响应拦截
    this.instance.interceptors.response.use((res) => {
      return res;
    });
  }

  request(config) {
    return new Promise((resolve, reject) => {
      this.instance
        .request(config)
        .then((res) => {
          resolve(res.data);
        })
        .catch((err) => {
          reject(err);
        });
    });
  }

  get(config) {
    return this.request({ ...config, method: "get" });
  }

  post(comfig) {
    return this.request({ ...comfig, method: "post" });
  }
}

//baseURL timeout
module.exports = new MyAxios("https://httpbin.org");

```

# 06. axios-ts(封装)

```ts
import type {
  AxiosRequestConfig,
  AxiosResponse,
  InternalAxiosRequestConfig,
} from "axios";

export interface RequestInterceptors<T = AxiosResponse> {
  // 请求拦截
  requestSuccessFn?: (
    config: InternalAxiosRequestConfig
  ) => InternalAxiosRequestConfig;
  requestFailureFn?: (err: any) => any;
  // 响应拦截
  responseSuccessFn?: (res: T) => T;
  responseFailureFn?: (err: any) => any;
}

export interface RequestConfig<T = AxiosResponse> extends AxiosRequestConfig {
  interceptors?: RequestInterceptors<T>;
}

```



```ts
import axios from "axios";
import type { AxiosInstance, AxiosRequestConfig } from "axios";
import type { RequestConfig } from "./type";

// 拦截器: 蒙版Loading/token/修改配置

/**
 * 两个难点:
 *  1.拦截器进行精细控制
 *    > 全局拦截器
 *    > 实例拦截器
 *    > 单次请求拦截器
 *
 *  2.响应结果的类型处理(泛型)
 */

// 拦截器的执行顺序为实例请求→类请求→实例响应→类响应

class Request {
  instaance: AxiosInstance;

  constructor(config: RequestConfig) {
    // 创建axios实例
    this.instaance = axios.create(config);

    // 添加全局拦截器
    // 1. 全局请求拦截器
    this.instaance.interceptors.request.use(
      (config) => {
        console.log("全局请求拦截器");

        return config;
      },
      (err) => {
        console.log(err);
      }
    );

    // 使用实例拦截器
    this.instaance.interceptors.request.use(
      config.interceptors?.requestSuccessFn,
      config.interceptors?.requestFailureFn
    );

    this.instaance.interceptors.response.use(
      config.interceptors?.responseSuccessFn,
      config.interceptors?.responseFailureFn
    );

    // 2. 全局响应拦截器
    //  全局响应拦截器保证最后执行
    this.instaance.interceptors.response.use(
      (res) => {
        console.log("全局响应拦截器");

        return res.data;
      },
      (err) => {
        console.log(err);
      }
    );
  }

  // this.request ==>  request<T = any, R = AxiosResponse<T>, D = any>(config: AxiosRequestConfig<D>): Promise<R>;
  request<T = any>(config: RequestConfig<T>): Promise<T> {
    // 单次请求的成功拦截处理(单个拦截器本身就是钩子函数)
    if (config.interceptors?.requestSuccessFn) {
      config = config.interceptors.requestSuccessFn(config as any);
    }

    // 返回Promise
    return new Promise((resolve, reject) => {
      this.instaance
        .request<any, T>(config)
        .then((res) => {
          // 单个响应的成功拦截处理
          if (config.interceptors?.responseSuccessFn) {
            res = config.interceptors.responseSuccessFn(res);
          }

          // 在全局拦截器中已将res类型改变 (res的类型不再是AxiosRequestConfig类型)
          resolve(res);
        })
        .catch((err) => {
          reject(err);
        });
    });
  }

  get<T = any>(config: RequestConfig<T>) {
    return this.request({ ...config, method: "GET" });
  }
  post<T = any>(config: RequestConfig<T>) {
    return this.request({ ...config, method: "POST" });
  }
  delete<T = any>(config: RequestConfig<T>) {
    return this.request({ ...config, method: "DELETE" });
  }
  patch<T = any>(config: RequestConfig<T>) {
    return this.request({ ...config, method: "PATCH" });
  }
}

export default Request;

```

```ts
//index.ts
import Request from "./request";

// 第一个实例
export const req1 = new Request({
  baseURL: "https://httpbin.org",
  timeout: 10000,
  // interceptors: {
  //   requestSuccessFn(config) {
  //     console.log("req1实例请求拦截器");
  //     return config;
  //   },

  //   responseSuccessFn(res) {
  //     console.log("req1实例响应拦截器");
  //     return res;
  //   },
  // },
});

// export const req2 = new Request({
//   baseURL: "https://httpbin.org",
//   timeout: 20000,

//   interceptors: {
//     requestSuccessFn(config) {
//       console.log("req2实例请求拦截");
//       return config;
//     },

//     responseSuccessFn(res) {
//       console.log("req2实例响应拦截器");
//       return res;
//     },
//   },
// });

```

