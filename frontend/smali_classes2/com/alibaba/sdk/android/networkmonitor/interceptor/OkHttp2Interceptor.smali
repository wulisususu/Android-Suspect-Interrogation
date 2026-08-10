.class public Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;
.super Ljava/lang/Object;
.source "OkHttp2Interceptor.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$b;
    }
.end annotation


# static fields
.field private static a:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/ref/WeakReference<",
            "Lcom/squareup/okhttp/Call;",
            ">;>;"
        }
    .end annotation
.end field


# instance fields
.field private a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/alibaba/sdk/android/networkmonitor/interceptor/c<",
            "Lcom/squareup/okhttp/Call;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$a;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$a;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;-><init>()V

    return-void
.end method

.method private a()Lcom/squareup/okhttp/Call;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Ljava/lang/ThreadLocal;

    .line 1
    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    .line 4
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/squareup/okhttp/Call;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private a(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/Request;
    .locals 3

    const/4 v0, 0x0

    .line 30
    :try_start_0
    const-class v1, Lcom/squareup/okhttp/Call;

    const-string v2, "originalRequest"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 33
    :catch_0
    :try_start_1
    const-class v1, Lcom/squareup/okhttp/Call;

    const-string v2, "request"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception v1

    .line 35
    invoke-virtual {v1}, Ljava/lang/NoSuchFieldException;->printStackTrace()V

    move-object v1, v0

    :goto_0
    if-eqz v1, :cond_0

    const/4 v2, 0x1

    .line 40
    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 42
    :try_start_2
    invoke-virtual {v1, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/squareup/okhttp/Request;
    :try_end_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_2 .. :try_end_2} :catch_2

    return-object p1

    :catch_2
    move-exception p1

    .line 44
    invoke-virtual {p1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    :cond_0
    return-object v0
.end method

.method private a()Ljava/lang/String;
    .locals 4

    :try_start_0
    const-string v0, "com.squareup.okhttp.internal.Version"

    .line 45
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    const-string v1, "userAgent"

    const/4 v2, 0x0

    :try_start_1
    new-array v3, v2, [Ljava/lang/Class;

    .line 46
    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    .line 47
    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/NoSuchMethodException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 55
    invoke-virtual {v0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    :catch_1
    move-exception v0

    .line 56
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    :catch_2
    move-exception v0

    .line 57
    invoke-virtual {v0}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    goto :goto_0

    :catch_3
    move-exception v0

    .line 58
    invoke-virtual {v0}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    :goto_0
    const-string v0, "okhttp2"

    return-object v0
.end method

.method private a(Lcom/squareup/okhttp/Address;)Ljava/lang/String;
    .locals 6

    .line 5
    invoke-virtual {p1}, Lcom/squareup/okhttp/Address;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v0, "https"

    goto :goto_0

    :cond_0
    const-string v0, "http"

    .line 6
    :goto_0
    invoke-virtual {p1}, Lcom/squareup/okhttp/Address;->getUriHost()Ljava/lang/String;

    move-result-object v1

    .line 7
    invoke-virtual {p1}, Lcom/squareup/okhttp/Address;->getUriPort()I

    move-result p1

    .line 9
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 10
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "://"

    .line 11
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v3, 0x3a

    .line 13
    invoke-virtual {v1, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_1

    const/16 v4, 0x5b

    .line 15
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 16
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x5d

    .line 17
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 19
    :cond_1
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 22
    :goto_1
    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a(Ljava/lang/String;I)I

    move-result p1

    .line 23
    invoke-static {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->defaultPort(Ljava/lang/String;)I

    move-result v0

    if-eq p1, v0, :cond_2

    .line 24
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 25
    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 28
    :cond_2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public static defaultPort(Ljava/lang/String;)I
    .locals 1

    const-string v0, "http"

    .line 1
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 p0, 0x50

    return p0

    :cond_0
    const-string v0, "https"

    .line 3
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    const/16 p0, 0x1bb

    return p0

    :cond_1
    const/4 p0, -0x1

    return p0
.end method

.method public static getInstance()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;
    .locals 1

    .line 1
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$b;->a()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method a(Ljava/lang/String;I)I
    .locals 1

    const/4 v0, -0x1

    if-eq p2, v0, :cond_0

    goto :goto_0

    .line 29
    :cond_0
    invoke-static {p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->defaultPort(Ljava/lang/String;)I

    move-result p2

    :goto_0
    return p2
.end method

.method public addTraceInterceptor(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/squareup/okhttp/Interceptor;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

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

    check-cast v1, Lcom/squareup/okhttp/Interceptor;

    .line 2
    instance-of v1, v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/b;

    if-eqz v1, :cond_1

    return-void

    .line 7
    :cond_2
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/b;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/b;-><init>()V

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public callEnd()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;)V

    return-void
.end method

.method public callFailed(Ljava/lang/Throwable;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/Throwable;)V

    return-void
.end method

.method public callStart(Lcom/squareup/okhttp/Call;)V
    .locals 1

    const/4 v0, 0x0

    .line 1
    invoke-virtual {p0, p1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->callStart(Lcom/squareup/okhttp/Call;Z)V

    return-void
.end method

.method public callStart(Lcom/squareup/okhttp/Call;Z)V
    .locals 3

    if-eqz p1, :cond_2

    if-eqz p2, :cond_0

    goto :goto_1

    .line 2
    :cond_0
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/Request;

    move-result-object p2

    if-eqz p2, :cond_1

    .line 4
    invoke-virtual {p2}, Lcom/squareup/okhttp/Request;->urlString()Ljava/lang/String;

    move-result-object v0

    .line 6
    invoke-virtual {p2}, Lcom/squareup/okhttp/Request;->method()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_1
    const-string v0, ""

    move-object p2, v0

    .line 9
    :goto_0
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 10
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, p1, v0, v2, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    :goto_1
    return-void
.end method

.method public connectEnd(Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lcom/squareup/okhttp/Protocol;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p3, :cond_1

    .line 8
    invoke-virtual {p3}, Lcom/squareup/okhttp/Protocol;->name()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_1
    const-string p3, ""

    :goto_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 11
    invoke-virtual {v1, v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Ljava/lang/String;)V

    return-void
.end method

.method public connectStart(Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V

    return-void
.end method

.method public connectionAcquired(Lcom/squareup/okhttp/Connection;Lcom/squareup/okhttp/Request;)V
    .locals 7

    .line 37
    invoke-virtual {p0, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->onStartRequest(Lcom/squareup/okhttp/Request;)V

    .line 38
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v1

    if-eqz v1, :cond_6

    if-nez p1, :cond_0

    goto :goto_4

    .line 48
    :cond_0
    invoke-virtual {p1}, Lcom/squareup/okhttp/Connection;->getRoute()Lcom/squareup/okhttp/Route;

    move-result-object p2

    const-string v0, ""

    if-eqz p2, :cond_3

    .line 50
    invoke-virtual {p2}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 52
    invoke-direct {p0, v2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a(Lcom/squareup/okhttp/Address;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_1
    move-object v2, v0

    .line 55
    :goto_0
    invoke-virtual {p2}, Lcom/squareup/okhttp/Route;->getSocketAddress()Ljava/net/InetSocketAddress;

    move-result-object p2

    if-eqz p2, :cond_2

    .line 57
    invoke-virtual {p2}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object p2

    if-eqz p2, :cond_2

    .line 59
    invoke-virtual {p2}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object p2

    move-object v3, p2

    goto :goto_1

    :cond_2
    move-object v3, v0

    goto :goto_1

    :cond_3
    move-object v2, v0

    move-object v3, v2

    .line 64
    :goto_1
    invoke-virtual {p1}, Lcom/squareup/okhttp/Connection;->getProtocol()Lcom/squareup/okhttp/Protocol;

    move-result-object p2

    if-eqz p2, :cond_4

    .line 66
    invoke-virtual {p2}, Lcom/squareup/okhttp/Protocol;->name()Ljava/lang/String;

    move-result-object p2

    move-object v4, p2

    goto :goto_2

    :cond_4
    move-object v4, v0

    .line 69
    :goto_2
    invoke-virtual {p1}, Lcom/squareup/okhttp/Connection;->getHandshake()Lcom/squareup/okhttp/Handshake;

    move-result-object p2

    if-eqz p2, :cond_5

    .line 71
    invoke-virtual {p2}, Lcom/squareup/okhttp/Handshake;->cipherSuite()Ljava/lang/String;

    move-result-object p2

    move-object v5, p2

    goto :goto_3

    :cond_5
    move-object v5, v0

    :goto_3
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 73
    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result v6

    invoke-virtual/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    :cond_6
    :goto_4
    return-void
.end method

.method public connectionAcquired(Lcom/squareup/okhttp/internal/io/RealConnection;)V
    .locals 7

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v1

    if-eqz v1, :cond_6

    if-nez p1, :cond_0

    goto/16 :goto_4

    .line 11
    :cond_0
    invoke-virtual {p1}, Lcom/squareup/okhttp/internal/io/RealConnection;->getRoute()Lcom/squareup/okhttp/Route;

    move-result-object v0

    const-string v2, ""

    if-eqz v0, :cond_3

    .line 13
    invoke-virtual {v0}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 15
    invoke-direct {p0, v3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a(Lcom/squareup/okhttp/Address;)Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_1
    move-object v3, v2

    .line 18
    :goto_0
    invoke-virtual {v0}, Lcom/squareup/okhttp/Route;->getSocketAddress()Ljava/net/InetSocketAddress;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 20
    invoke-virtual {v0}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 22
    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    move-object v4, v0

    goto :goto_1

    :cond_2
    move-object v4, v2

    goto :goto_1

    :cond_3
    move-object v3, v2

    move-object v4, v3

    .line 27
    :goto_1
    invoke-virtual {p1}, Lcom/squareup/okhttp/internal/io/RealConnection;->getProtocol()Lcom/squareup/okhttp/Protocol;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 29
    invoke-virtual {v0}, Lcom/squareup/okhttp/Protocol;->name()Ljava/lang/String;

    move-result-object v0

    move-object v5, v0

    goto :goto_2

    :cond_4
    move-object v5, v2

    .line 32
    :goto_2
    invoke-virtual {p1}, Lcom/squareup/okhttp/internal/io/RealConnection;->getHandshake()Lcom/squareup/okhttp/Handshake;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 34
    invoke-virtual {v0}, Lcom/squareup/okhttp/Handshake;->cipherSuite()Ljava/lang/String;

    move-result-object v0

    move-object v6, v0

    goto :goto_3

    :cond_5
    move-object v6, v2

    :goto_3
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 36
    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result p1

    move-object v2, v3

    move-object v3, v4

    move-object v4, v5

    move-object v5, v6

    move v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    :cond_6
    :goto_4
    return-void
.end method

.method public dnsEnd(Ljava/lang/String;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/net/InetAddress;",
            ">;)V"
        }
    .end annotation

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-eqz v0, :cond_1

    if-eqz p2, :cond_1

    .line 2
    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/util/List;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public dnsEnd(Ljava/lang/String;[Ljava/net/InetAddress;)V
    .locals 4

    .line 7
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-eqz v0, :cond_2

    if-eqz p2, :cond_2

    .line 8
    array-length v1, p2

    if-nez v1, :cond_0

    goto :goto_1

    .line 12
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x0

    .line 13
    :goto_0
    array-length v3, p2

    if-eq v2, v3, :cond_1

    .line 14
    aget-object v3, p2, v2

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 17
    invoke-virtual {p2, v0, p1, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/util/List;)V

    :cond_2
    :goto_1
    return-void
.end method

.method public dnsStart(Ljava/lang/String;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public followUp(Lcom/squareup/okhttp/Request;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    .line 6
    :goto_0
    invoke-virtual {v1, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Z)V

    return-void
.end method

.method public getTraceId()Ljava/lang/String;
    .locals 3

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v2, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    .line 11
    :cond_1
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/a;->a()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onStartRequest(Lcom/squareup/okhttp/Request;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    return-void
.end method

.method public requestBodyEnd()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->c(Ljava/lang/Object;)V

    return-void
.end method

.method public requestBodyStart()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->d(Ljava/lang/Object;)V

    return-void
.end method

.method public requestHeadersEnd(Lcom/squareup/okhttp/Request;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p1, :cond_1

    .line 8
    invoke-virtual {p1}, Lcom/squareup/okhttp/Request;->headers()Lcom/squareup/okhttp/Headers;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 10
    invoke-virtual {p1}, Lcom/squareup/okhttp/Headers;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_1
    const-string p1, ""

    :goto_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 14
    invoke-virtual {v1, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->c(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public requestHeadersStart(Lcom/squareup/okhttp/Request;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p1, :cond_1

    .line 8
    invoke-virtual {p1}, Lcom/squareup/okhttp/Request;->method()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_1
    const-string p1, ""

    :goto_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 11
    invoke-virtual {v1, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->d(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public responseBodyEnd(I)V
    .locals 4

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    int-to-long v2, p1

    .line 6
    invoke-virtual {v1, v0, v2, v3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;J)V

    return-void
.end method

.method public responseBodyStart()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->e(Ljava/lang/Object;)V

    return-void
.end method

.method public responseHeadersEnd(Lcom/squareup/okhttp/Response;)V
    .locals 6

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-string v1, ""

    const/4 v2, 0x0

    if-eqz p1, :cond_2

    .line 11
    invoke-virtual {p1}, Lcom/squareup/okhttp/Response;->code()I

    move-result v3

    .line 12
    invoke-virtual {p1}, Lcom/squareup/okhttp/Response;->headers()Lcom/squareup/okhttp/Headers;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 14
    invoke-virtual {v4}, Lcom/squareup/okhttp/Headers;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v5, 0x65

    if-ne v3, v5, :cond_1

    const-string v5, "upgrade"

    .line 17
    invoke-virtual {v4, v5}, Lcom/squareup/okhttp/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 18
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    const-string v5, "websocket"

    invoke-virtual {v4, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v2, 0x1

    :cond_1
    const-string v4, "Content-Type"

    .line 24
    invoke-virtual {p1, v4}, Lcom/squareup/okhttp/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_2
    const/4 v3, -0x1

    move-object p1, v1

    :goto_0
    iget-object v4, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 27
    invoke-virtual {v4, v0, v1, v3, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;ILjava/lang/String;)V

    if-eqz v2, :cond_3

    iget-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 30
    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;)V

    :cond_3
    return-void
.end method

.method public responseHeadersStart()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->f(Ljava/lang/Object;)V

    return-void
.end method

.method public secureConnectEnd(Ljava/net/Socket;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 7
    :cond_0
    instance-of v1, p1, Ljavax/net/ssl/SSLSocket;

    if-eqz v1, :cond_1

    .line 8
    check-cast p1, Ljavax/net/ssl/SSLSocket;

    invoke-virtual {p1}, Ljavax/net/ssl/SSLSocket;->getSession()Ljavax/net/ssl/SSLSession;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 10
    invoke-interface {p1}, Ljavax/net/ssl/SSLSession;->getProtocol()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_1
    const-string p1, ""

    :goto_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 14
    invoke-virtual {v1, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->e(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public secureConnectStart()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->g(Ljava/lang/Object;)V

    return-void
.end method

.method public setCall(Lcom/squareup/okhttp/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sget-object p1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Ljava/lang/ThreadLocal;

    .line 2
    invoke-virtual {p1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    return-void
.end method

.method public setRequestBodyLength(J)V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a()Lcom/squareup/okhttp/Call;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 6
    invoke-virtual {v1, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->c(Ljava/lang/Object;J)V

    return-void
.end method
