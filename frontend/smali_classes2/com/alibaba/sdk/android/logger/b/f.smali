.class public Lcom/alibaba/sdk/android/logger/b/f;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/logger/ILog;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/b/f;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/alibaba/sdk/android/logger/b/f;->b:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    return-void
.end method


# virtual methods
.method public d(Ljava/lang/String;)V
    .locals 0

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/logger/b/f;->d([Ljava/lang/Object;)V

    return-void
.end method

.method public varargs d([Ljava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/b/f;->b:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    sget-object v1, Lcom/alibaba/sdk/android/logger/LogLevel;->DEBUG:Lcom/alibaba/sdk/android/logger/LogLevel;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/b/f;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, p1}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/logger/b/f;->e([Ljava/lang/Object;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/logger/b/f;->e([Ljava/lang/Object;)V

    return-void
.end method

.method public varargs e([Ljava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/b/f;->b:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    sget-object v1, Lcom/alibaba/sdk/android/logger/LogLevel;->ERROR:Lcom/alibaba/sdk/android/logger/LogLevel;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/b/f;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, p1}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/logger/b/f;->i([Ljava/lang/Object;)V

    return-void
.end method

.method public varargs i([Ljava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/b/f;->b:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    sget-object v1, Lcom/alibaba/sdk/android/logger/LogLevel;->INFO:Lcom/alibaba/sdk/android/logger/LogLevel;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/b/f;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, p1}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public w(Ljava/lang/String;)V
    .locals 0

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/logger/b/f;->w([Ljava/lang/Object;)V

    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/logger/b/f;->w([Ljava/lang/Object;)V

    return-void
.end method

.method public varargs w([Ljava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/b/f;->b:Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    sget-object v1, Lcom/alibaba/sdk/android/logger/LogLevel;->WARN:Lcom/alibaba/sdk/android/logger/LogLevel;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/b/f;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, p1}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
