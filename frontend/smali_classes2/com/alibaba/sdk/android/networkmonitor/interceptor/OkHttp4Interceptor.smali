.class public Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;
.super Ljava/lang/Object;
.source "OkHttp4Interceptor.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$b;
    }
.end annotation


# instance fields
.field private a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/alibaba/sdk/android/networkmonitor/interceptor/c<",
            "Lokhttp3/Call;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$a;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$a;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;-><init>()V

    return-void
.end method

.method private a(Lokhttp3/Response;)I
    .locals 1

    if-eqz p1, :cond_0

    .line 54
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/Response;->code()I

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return p1

    :catchall_0
    move-exception p1

    .line 56
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const/4 p1, -0x1

    return p1
.end method

.method private a()Ljava/lang/String;
    .locals 2

    const-string v0, "okhttp/"

    .line 4
    :try_start_0
    sget-object v0, Lokhttp3/internal/Util;->userAgent:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    .line 10
    :catchall_0
    :try_start_1
    sget-object v0, Lokhttp3/internal/Version;->userAgent:Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    return-object v0

    .line 16
    :catchall_1
    :try_start_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v0, Lokhttp3/OkHttp;->VERSION:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    return-object v0

    :catchall_2
    const-string v0, "okhttp/unknown"

    return-object v0
.end method

.method private a(Lokhttp3/Call;)Ljava/lang/String;
    .locals 1

    .line 17
    :try_start_0
    invoke-interface {p1}, Lokhttp3/Call;->request()Lokhttp3/Request;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 19
    invoke-virtual {p1}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 22
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private a(Lokhttp3/Connection;)Ljava/lang/String;
    .locals 1

    .line 57
    :try_start_0
    invoke-interface {p1}, Lokhttp3/Connection;->route()Lokhttp3/Route;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 59
    invoke-virtual {p1}, Lokhttp3/Route;->address()Lokhttp3/Address;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 61
    invoke-virtual {p1}, Lokhttp3/Address;->url()Lokhttp3/HttpUrl;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 63
    invoke-virtual {p1}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 68
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private a(Lokhttp3/Handshake;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_0

    .line 23
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/Handshake;->tlsVersion()Lokhttp3/TlsVersion;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 25
    invoke-virtual {p1}, Lokhttp3/TlsVersion;->javaName()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 28
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private a(Lokhttp3/Protocol;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_0

    .line 48
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/Protocol;->name()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 50
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private a(Lokhttp3/Request;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_0

    .line 29
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 31
    invoke-virtual {p1}, Lokhttp3/Headers;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 34
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private a(Lokhttp3/Response;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    const-string v0, "Content-Type"

    .line 51
    invoke-virtual {p1, v0}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 53
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private a(Lokhttp3/Call;)Z
    .locals 2

    .line 1
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "forWebSocket"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v1, 0x1

    .line 2
    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 3
    invoke-virtual {v0, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return p1

    :catchall_0
    const/4 p1, 0x0

    return p1
.end method

.method private a(Lokhttp3/Response;)Z
    .locals 2

    if-eqz p1, :cond_0

    .line 35
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Response;)I

    move-result v0

    const/16 v1, 0x65

    if-ne v0, v1, :cond_0

    .line 38
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object p1

    if-eqz p1, :cond_0

    const-string v0, "upgrade"

    .line 41
    invoke-virtual {p1, v0}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 42
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    const-string v0, "websocket"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :catchall_0
    move-exception p1

    .line 47
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method private b(Lokhttp3/Call;)Ljava/lang/String;
    .locals 1

    .line 1
    :try_start_0
    invoke-interface {p1}, Lokhttp3/Call;->request()Lokhttp3/Request;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 3
    invoke-virtual {p1}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 5
    invoke-virtual {p1}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 9
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private b(Lokhttp3/Connection;)Ljava/lang/String;
    .locals 1

    .line 19
    :try_start_0
    invoke-interface {p1}, Lokhttp3/Connection;->route()Lokhttp3/Route;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 21
    invoke-virtual {p1}, Lokhttp3/Route;->socketAddress()Ljava/net/InetSocketAddress;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 23
    invoke-virtual {p1}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 25
    invoke-virtual {p1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 30
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private b(Lokhttp3/Request;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_0

    .line 10
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 12
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private b(Lokhttp3/Response;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_0

    .line 13
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 15
    invoke-virtual {p1}, Lokhttp3/Headers;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 18
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private c(Lokhttp3/Connection;)Ljava/lang/String;
    .locals 1

    .line 1
    :try_start_0
    invoke-interface {p1}, Lokhttp3/Connection;->protocol()Lokhttp3/Protocol;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 3
    invoke-virtual {p1}, Lokhttp3/Protocol;->name()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 6
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method private d(Lokhttp3/Connection;)Ljava/lang/String;
    .locals 1

    .line 1
    :try_start_0
    invoke-interface {p1}, Lokhttp3/Connection;->handshake()Lokhttp3/Handshake;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 3
    invoke-virtual {p1}, Lokhttp3/Handshake;->tlsVersion()Lokhttp3/TlsVersion;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 5
    invoke-virtual {p1}, Lokhttp3/TlsVersion;->javaName()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 9
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OkHttp4Interceptor"

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string p1, ""

    return-object p1
.end method

.method public static getInstance()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;
    .locals 1

    .line 1
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$b;->a()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public addTraceInterceptor(Ljava/util/List;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lokhttp3/Interceptor;",
            ">;)",
            "Ljava/util/List<",
            "Lokhttp3/Interceptor;",
            ">;"
        }
    .end annotation

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 1
    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lokhttp3/Interceptor;

    .line 2
    instance-of v1, v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4TraceInterceptor;

    if-eqz v1, :cond_1

    return-object p1

    .line 7
    :cond_2
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4TraceInterceptor;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4TraceInterceptor;-><init>()V

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p1
.end method

.method public callEnd(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;)V

    return-void
.end method

.method public callFailed(Lokhttp3/Call;Ljava/lang/Throwable;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/Throwable;)V

    return-void
.end method

.method public callStart(Lokhttp3/Call;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Call;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    .line 5
    :cond_1
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->b(Lokhttp3/Call;)Ljava/lang/String;

    move-result-object v0

    .line 6
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Call;)Ljava/lang/String;

    move-result-object v1

    .line 8
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 9
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p1, v0, v3, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    return-void
.end method

.method public connectEnd(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    invoke-direct {p0, p4}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Protocol;)Ljava/lang/String;

    move-result-object p4

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 3
    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Ljava/lang/String;)V

    return-void
.end method

.method public connectFailed(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;Ljava/io/IOException;)V
    .locals 6

    if-nez p1, :cond_0

    return-void

    :cond_0
    if-eqz p4, :cond_1

    .line 1
    invoke-virtual {p4}, Lokhttp3/Protocol;->name()Ljava/lang/String;

    move-result-object p4

    goto :goto_0

    :cond_1
    const-string p4, ""

    :goto_0
    move-object v4, p4

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v5, p5

    .line 4
    invoke-virtual/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Ljava/lang/String;Ljava/io/IOException;)V

    return-void
.end method

.method public connectStart(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V

    return-void
.end method

.method public connectionAcquired(Lokhttp3/Call;Lokhttp3/Connection;)V
    .locals 7

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    .line 1
    :cond_0
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Connection;)Ljava/lang/String;

    move-result-object v2

    .line 2
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->b(Lokhttp3/Connection;)Ljava/lang/String;

    move-result-object v3

    .line 3
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->c(Lokhttp3/Connection;)Ljava/lang/String;

    move-result-object v4

    .line 4
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->d(Lokhttp3/Connection;)Ljava/lang/String;

    move-result-object v5

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {p2}, Ljava/lang/Object;->hashCode()I

    move-result v6

    move-object v1, p1

    invoke-virtual/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    :cond_1
    :goto_0
    return-void
.end method

.method public connectionReleased(Lokhttp3/Call;Lokhttp3/Connection;)V
    .locals 1

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {p2}, Ljava/lang/Object;->hashCode()I

    move-result p2

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;I)V

    :cond_1
    :goto_0
    return-void
.end method

.method public correctRequest(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 1

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    .line 1
    :cond_0
    invoke-virtual {p2}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object p2

    if-eqz p2, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 3
    invoke-virtual {p2}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public dnsEnd(Lokhttp3/Call;Ljava/lang/String;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lokhttp3/Call;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/net/InetAddress;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    if-eqz p3, :cond_1

    .line 1
    invoke-interface {p3}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 5
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/util/List;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public dnsStart(Lokhttp3/Call;Ljava/lang/String;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public encounterException(Lokhttp3/Call;ZLjava/lang/Throwable;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    :try_start_0
    instance-of v0, p3, Lokhttp3/internal/connection/RouteException;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_1

    .line 3
    :try_start_1
    move-object v0, p3

    check-cast v0, Lokhttp3/internal/connection/RouteException;

    invoke-virtual {v0}, Lokhttp3/internal/connection/RouteException;->getFirstConnectException()Ljava/io/IOException;

    move-result-object p3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 6
    :catchall_0
    :try_start_2
    move-object v0, p3

    check-cast v0, Lokhttp3/internal/connection/RouteException;

    invoke-virtual {v0}, Lokhttp3/internal/connection/RouteException;->getLastConnectException()Ljava/io/IOException;

    move-result-object p3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :catchall_1
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 15
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;ZLjava/lang/Throwable;)V

    return-void
.end method

.method public getTraceId(Lokhttp3/Call;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v1, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object p1

    if-nez p1, :cond_1

    return-object v0

    .line 6
    :cond_1
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public onStartRequest(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    return-void
.end method

.method public requestBodyEnd(Lokhttp3/Call;J)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;J)V

    return-void
.end method

.method public requestBodyStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->d(Ljava/lang/Object;)V

    return-void
.end method

.method public requestHeadersEnd(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Request;)Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 3
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->c(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public requestHeadersStart(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->b(Lokhttp3/Request;)Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 3
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->d(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public responseBodyEnd(Lokhttp3/Call;J)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;J)V

    return-void
.end method

.method public responseBodyStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->e(Ljava/lang/Object;)V

    return-void
.end method

.method public responseHeadersEnd(Lokhttp3/Call;Lokhttp3/Response;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->b(Lokhttp3/Response;)Ljava/lang/String;

    move-result-object v0

    .line 2
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Response;)I

    move-result v1

    .line 3
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Response;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 5
    invoke-virtual {v3, p1, v0, v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;ILjava/lang/String;)V

    .line 7
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Response;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 8
    invoke-virtual {p2, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;)V

    :cond_1
    return-void
.end method

.method public responseHeadersStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->f(Ljava/lang/Object;)V

    return-void
.end method

.method public secureConnectEnd(Lokhttp3/Call;Lokhttp3/Handshake;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    invoke-direct {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a(Lokhttp3/Handshake;)Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 3
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->e(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public secureConnectStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->g(Ljava/lang/Object;)V

    return-void
.end method
