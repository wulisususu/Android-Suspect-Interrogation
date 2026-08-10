.class public Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;
.super Ljava/lang/Object;


# instance fields
.field private a:Lcom/alibaba/sdk/android/logger/b/g;

.field private b:Lcom/alibaba/sdk/android/logger/b/e;

.field private c:Lcom/alibaba/sdk/android/logger/a/a;

.field private d:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

.field private e:Lcom/alibaba/sdk/android/logger/b/b;


# direct methods
.method public constructor <init>(Ljava/lang/String;Z)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/alibaba/sdk/android/logger/a/a;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/logger/a/a;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->c:Lcom/alibaba/sdk/android/logger/a/a;

    new-instance v0, Lcom/alibaba/sdk/android/logger/b/b;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/logger/b/b;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->e:Lcom/alibaba/sdk/android/logger/b/b;

    new-instance v0, Lcom/alibaba/sdk/android/logger/b/g;

    invoke-direct {v0, p1}, Lcom/alibaba/sdk/android/logger/b/g;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->a:Lcom/alibaba/sdk/android/logger/b/g;

    new-instance p1, Lcom/alibaba/sdk/android/logger/b/e;

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->e:Lcom/alibaba/sdk/android/logger/b/b;

    invoke-direct {p1, v0}, Lcom/alibaba/sdk/android/logger/b/e;-><init>(Lcom/alibaba/sdk/android/logger/b/b;)V

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->b:Lcom/alibaba/sdk/android/logger/b/e;

    new-instance p1, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    new-instance v0, Lcom/alibaba/sdk/android/logger/interceptor/a;

    new-instance v1, Lcom/alibaba/sdk/android/logger/b/h;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->c:Lcom/alibaba/sdk/android/logger/a/a;

    invoke-direct {v1, v2}, Lcom/alibaba/sdk/android/logger/b/h;-><init>(Lcom/alibaba/sdk/android/logger/a/a;)V

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/logger/interceptor/a;-><init>(Lcom/alibaba/sdk/android/logger/interceptor/d;)V

    new-instance v1, Lcom/alibaba/sdk/android/logger/interceptor/b;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->b:Lcom/alibaba/sdk/android/logger/b/e;

    invoke-direct {v1, v2}, Lcom/alibaba/sdk/android/logger/interceptor/b;-><init>(Lcom/alibaba/sdk/android/logger/ILogger;)V

    invoke-direct {p1, v0, v1}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;-><init>(Lcom/alibaba/sdk/android/logger/interceptor/a;Lcom/alibaba/sdk/android/logger/interceptor/b;)V

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->d:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    new-instance v0, Lcom/alibaba/sdk/android/logger/b/c;

    iget-object v1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->b:Lcom/alibaba/sdk/android/logger/b/e;

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/logger/b/c;-><init>(Lcom/alibaba/sdk/android/logger/b/e;)V

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a(Lcom/alibaba/sdk/android/logger/interceptor/ILogInterceptor;)V

    if-eqz p2, :cond_0

    iget-object p1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->e:Lcom/alibaba/sdk/android/logger/b/b;

    sget-object p2, Lcom/alibaba/sdk/android/logger/LogLevel;->DEBUG:Lcom/alibaba/sdk/android/logger/LogLevel;

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/logger/b/b;->a(Lcom/alibaba/sdk/android/logger/LogLevel;)V

    iget-object p1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->d:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    new-instance p2, Lcom/alibaba/sdk/android/logger/b/a;

    invoke-direct {p2}, Lcom/alibaba/sdk/android/logger/b/a;-><init>()V

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a(Lcom/alibaba/sdk/android/logger/interceptor/c;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public addILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->b:Lcom/alibaba/sdk/android/logger/b/e;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/logger/b/e;->b(Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method

.method public addObjectFormat(Ljava/lang/Class;Lcom/alibaba/sdk/android/logger/IObjectLogFormat;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;",
            "Lcom/alibaba/sdk/android/logger/IObjectLogFormat<",
            "TT;>;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->c:Lcom/alibaba/sdk/android/logger/a/a;

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/logger/a/a;->a(Ljava/lang/Class;Lcom/alibaba/sdk/android/logger/IObjectLogFormat;)V

    return-void
.end method

.method public enable(Z)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->e:Lcom/alibaba/sdk/android/logger/b/b;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/logger/b/b;->a(Z)V

    return-void
.end method

.method public getLogBuilder(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/LogBuilder;
    .locals 3

    new-instance v0, Lcom/alibaba/sdk/android/logger/LogBuilder;

    iget-object v1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->d:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->a:Lcom/alibaba/sdk/android/logger/b/g;

    invoke-direct {v0, v1, p1, v2}, Lcom/alibaba/sdk/android/logger/LogBuilder;-><init>(Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;Ljava/lang/Object;Lcom/alibaba/sdk/android/logger/b/g;)V

    return-object v0
.end method

.method public getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;
    .locals 2

    new-instance v0, Lcom/alibaba/sdk/android/logger/b/f;

    iget-object v1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->a:Lcom/alibaba/sdk/android/logger/b/g;

    invoke-virtual {v1, p1}, Lcom/alibaba/sdk/android/logger/b/g;->a(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->d:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    invoke-direct {v0, p1, v1}, Lcom/alibaba/sdk/android/logger/b/f;-><init>(Ljava/lang/String;Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;)V

    return-object v0
.end method

.method public removeILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->b:Lcom/alibaba/sdk/android/logger/b/e;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/logger/b/e;->c(Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method

.method public setILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->b:Lcom/alibaba/sdk/android/logger/b/e;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/logger/b/e;->a(Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method

.method public setLevel(Lcom/alibaba/sdk/android/logger/LogLevel;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->e:Lcom/alibaba/sdk/android/logger/b/b;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/logger/b/b;->a(Lcom/alibaba/sdk/android/logger/LogLevel;)V

    return-void
.end method
