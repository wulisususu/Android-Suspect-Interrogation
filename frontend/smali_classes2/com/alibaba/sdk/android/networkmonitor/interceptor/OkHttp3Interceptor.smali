.class public Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;
.super Ljava/lang/Object;
.source "OkHttp3Interceptor.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor$b;
    }
.end annotation


# static fields
.field private static a:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/ref/WeakReference<",
            "Lokhttp3/Call;",
            ">;>;"
        }
    .end annotation
.end field


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
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor$a;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor$a;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;-><init>()V

    return-void
.end method

.method private a()Lokhttp3/Call;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Ljava/lang/ThreadLocal;

    .line 1
    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    .line 4
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/Call;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private a(Lokhttp3/Call;Ljava/lang/String;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 8
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method private a(Lokhttp3/Call;Ljava/lang/String;Ljava/util/List;)V
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

    .line 9
    invoke-interface {p3}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 13
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/util/List;)V

    :cond_1
    :goto_0
    return-void
.end method

.method private a(Lokhttp3/Call;)Z
    .locals 2

    .line 5
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "forWebSocket"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v1, 0x1

    .line 6
    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 7
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

.method public static getInstance()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;
    .locals 1

    .line 1
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor$b;->a()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;

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
    instance-of v1, v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3TraceInterceptor;

    if-eqz v1, :cond_1

    return-object p1

    .line 7
    :cond_2
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3TraceInterceptor;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3TraceInterceptor;-><init>()V

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p1
.end method

.method public callEnd(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;)V

    return-void
.end method

.method public callEnd(Z)V
    .locals 0

    if-eqz p1, :cond_0

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->callEnd(Lokhttp3/Call;)V

    :cond_0
    return-void
.end method

.method public callFailed(Ljava/lang/Throwable;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->callFailed(Lokhttp3/Call;Ljava/lang/Throwable;)V

    return-void
.end method

.method public callFailed(Lokhttp3/Call;Ljava/lang/Throwable;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/Throwable;)V

    return-void
.end method

.method public callStart(Lokhttp3/Call;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a(Lokhttp3/Call;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    .line 8
    :cond_1
    invoke-interface {p1}, Lokhttp3/Call;->request()Lokhttp3/Request;

    move-result-object v0

    const-string v1, ""

    if-eqz v0, :cond_3

    .line 10
    invoke-virtual {v0}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 12
    invoke-virtual {v2}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v1

    .line 15
    :cond_2
    invoke-virtual {v0}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_3
    move-object v0, v1

    .line 18
    :goto_0
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 19
    invoke-static {}, Lokhttp3/internal/Version;->userAgent()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p1, v1, v3, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    return-void
.end method

.method public connectEnd(Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->connectEnd(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;)V

    return-void
.end method

.method public connectEnd(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    if-eqz p4, :cond_1

    .line 2
    invoke-virtual {p4}, Lokhttp3/Protocol;->name()Ljava/lang/String;

    move-result-object p4

    goto :goto_0

    :cond_1
    const-string p4, ""

    :goto_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 5
    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Ljava/lang/String;)V

    return-void
.end method

.method public connectFailed(Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;Ljava/io/IOException;)V
    .locals 6

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v1

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->connectFailed(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;Ljava/io/IOException;)V

    return-void
.end method

.method public connectFailed(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lokhttp3/Protocol;Ljava/io/IOException;)V
    .locals 6

    if-nez p1, :cond_0

    return-void

    :cond_0
    if-eqz p4, :cond_1

    .line 2
    invoke-virtual {p4}, Lokhttp3/Protocol;->name()Ljava/lang/String;

    move-result-object p4

    goto :goto_0

    :cond_1
    const-string p4, ""

    :goto_0
    move-object v4, p4

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v5, p5

    .line 5
    invoke-virtual/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Ljava/lang/String;Ljava/io/IOException;)V

    return-void
.end method

.method public connectStart(Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->connectStart(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V

    return-void
.end method

.method public connectStart(Lokhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V

    return-void
.end method

.method public connectionAcquired(Lokhttp3/Call;Lokhttp3/Connection;)V
    .locals 10

    if-eqz p1, :cond_6

    if-nez p2, :cond_0

    goto/16 :goto_4

    .line 2
    :cond_0
    invoke-interface {p2}, Lokhttp3/Connection;->route()Lokhttp3/Route;

    move-result-object v0

    const-string v1, ""

    if-eqz v0, :cond_3

    .line 4
    invoke-virtual {v0}, Lokhttp3/Route;->address()Lokhttp3/Address;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 6
    invoke-virtual {v2}, Lokhttp3/Address;->url()Lokhttp3/HttpUrl;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 8
    invoke-virtual {v2}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_1
    move-object v2, v1

    .line 12
    :goto_0
    invoke-virtual {v0}, Lokhttp3/Route;->socketAddress()Ljava/net/InetSocketAddress;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 14
    invoke-virtual {v0}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 16
    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    move-object v6, v0

    goto :goto_1

    :cond_2
    move-object v6, v1

    :goto_1
    move-object v5, v2

    goto :goto_2

    :cond_3
    move-object v5, v1

    move-object v6, v5

    .line 21
    :goto_2
    invoke-interface {p2}, Lokhttp3/Connection;->protocol()Lokhttp3/Protocol;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 23
    invoke-virtual {v0}, Lokhttp3/Protocol;->name()Ljava/lang/String;

    move-result-object v0

    move-object v7, v0

    goto :goto_3

    :cond_4
    move-object v7, v1

    .line 26
    :goto_3
    invoke-interface {p2}, Lokhttp3/Connection;->handshake()Lokhttp3/Handshake;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 28
    invoke-virtual {v0}, Lokhttp3/Handshake;->tlsVersion()Lokhttp3/TlsVersion;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 30
    invoke-virtual {v0}, Lokhttp3/TlsVersion;->javaName()Ljava/lang/String;

    move-result-object v1

    :cond_5
    move-object v8, v1

    iget-object v3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 34
    invoke-virtual {p2}, Ljava/lang/Object;->hashCode()I

    move-result v9

    move-object v4, p1

    invoke-virtual/range {v3 .. v9}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    :cond_6
    :goto_4
    return-void
.end method

.method public connectionAcquired(Lokhttp3/Connection;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->connectionAcquired(Lokhttp3/Call;Lokhttp3/Connection;)V

    return-void
.end method

.method public connectionReleased(Lokhttp3/Call;Lokhttp3/Connection;)V
    .locals 1

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {p2}, Ljava/lang/Object;->hashCode()I

    move-result p2

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;I)V

    :cond_1
    :goto_0
    return-void
.end method

.method public connectionReleased(Lokhttp3/Connection;)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result p1

    invoke-virtual {v0, v1, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;I)V

    return-void
.end method

.method public correctRequest(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 1

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    .line 2
    :cond_0
    invoke-virtual {p2}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object p2

    if-eqz p2, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 4
    invoke-virtual {p2}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public correctRequest(Lokhttp3/Request;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->correctRequest(Lokhttp3/Call;Lokhttp3/Request;)V

    return-void
.end method

.method public dnsEnd(Ljava/lang/String;Ljava/util/List;)V
    .locals 1
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
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-direct {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a(Lokhttp3/Call;Ljava/lang/String;Ljava/util/List;)V

    return-void
.end method

.method public dnsEnd(Lokhttp3/Call;Ljava/lang/Object;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lokhttp3/Call;",
            "Ljava/lang/Object;",
            "Ljava/util/List<",
            "Ljava/net/InetAddress;",
            ">;)V"
        }
    .end annotation

    .line 2
    instance-of v0, p2, Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 3
    check-cast p2, Ljava/lang/String;

    invoke-direct {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a(Lokhttp3/Call;Ljava/lang/String;Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method public dnsStart(Ljava/lang/String;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-direct {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a(Lokhttp3/Call;Ljava/lang/String;)V

    return-void
.end method

.method public dnsStart(Lokhttp3/Call;Ljava/lang/Object;)V
    .locals 1

    .line 2
    instance-of v0, p2, Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 3
    check-cast p2, Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a(Lokhttp3/Call;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public encounterException(Lokhttp3/Call;ZLjava/lang/Throwable;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    .line 2
    :cond_0
    :try_start_0
    instance-of v0, p3, Lokhttp3/internal/connection/RouteException;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_1

    .line 4
    :try_start_1
    move-object v0, p3

    check-cast v0, Lokhttp3/internal/connection/RouteException;

    invoke-virtual {v0}, Lokhttp3/internal/connection/RouteException;->getFirstConnectException()Ljava/io/IOException;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 7
    :catchall_0
    :try_start_2
    move-object v0, p3

    check-cast v0, Lokhttp3/internal/connection/RouteException;

    invoke-virtual {v0}, Lokhttp3/internal/connection/RouteException;->getLastConnectException()Ljava/io/IOException;

    move-result-object v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_0

    :catchall_1
    :cond_1
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_2

    .line 19
    :try_start_3
    instance-of v1, p3, Lokhttp3/internal/http/RouteException;

    if-eqz v1, :cond_2

    .line 21
    move-object v1, p3

    check-cast v1, Lokhttp3/internal/http/RouteException;

    invoke-virtual {v1}, Lokhttp3/internal/http/RouteException;->getLastConnectException()Ljava/io/IOException;

    move-result-object v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    :catchall_2
    :cond_2
    if-nez v0, :cond_3

    goto :goto_1

    :cond_3
    move-object p3, v0

    :goto_1
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 34
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;ZLjava/lang/Throwable;)V

    return-void
.end method

.method public encounterException(Lokhttp3/internal/http/HttpEngine;Ljava/lang/Throwable;)V
    .locals 1

    .line 35
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    invoke-virtual {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->encounterException(Lokhttp3/Call;ZLjava/lang/Throwable;)V

    return-void
.end method

.method public encounterException(ZLjava/lang/Throwable;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->encounterException(Lokhttp3/Call;ZLjava/lang/Throwable;)V

    return-void
.end method

.method public followUp(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    if-eqz p2, :cond_1

    const/4 p2, 0x1

    goto :goto_0

    :cond_1
    const/4 p2, 0x0

    .line 2
    :goto_0
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Z)V

    return-void
.end method

.method public followUp(Lokhttp3/Request;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->followUp(Lokhttp3/Call;Lokhttp3/Request;)V

    return-void
.end method

.method public getTraceId()Ljava/lang/String;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->getTraceId(Lokhttp3/Call;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getTraceId(Lokhttp3/Call;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v1, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object p1

    if-nez p1, :cond_1

    return-object v0

    .line 7
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

.method public onStartRequest(Lokhttp3/Request;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->onStartRequest(Lokhttp3/Call;Lokhttp3/Request;)V

    return-void
.end method

.method public requestBodyEnd(J)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->requestBodyEnd(Lokhttp3/Call;J)V

    return-void
.end method

.method public requestBodyEnd(Lokhttp3/Call;J)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;J)V

    return-void
.end method

.method public requestBodyStart()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->requestBodyStart(Lokhttp3/Call;)V

    return-void
.end method

.method public requestBodyStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->d(Ljava/lang/Object;)V

    return-void
.end method

.method public requestHeadersEnd(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    if-eqz p2, :cond_1

    .line 2
    invoke-virtual {p2}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object p2

    if-eqz p2, :cond_1

    .line 4
    invoke-virtual {p2}, Lokhttp3/Headers;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_1
    const-string p2, ""

    :goto_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 8
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->c(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public requestHeadersEnd(Lokhttp3/Request;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->requestHeadersEnd(Lokhttp3/Call;Lokhttp3/Request;)V

    return-void
.end method

.method public requestHeadersStart(Lokhttp3/Call;Lokhttp3/Request;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    if-eqz p2, :cond_1

    .line 2
    invoke-virtual {p2}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_1
    const-string p2, ""

    :goto_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 5
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->d(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public requestHeadersStart(Lokhttp3/Request;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->requestHeadersStart(Lokhttp3/Call;Lokhttp3/Request;)V

    return-void
.end method

.method public responseBodyEnd(J)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->responseBodyEnd(Lokhttp3/Call;J)V

    return-void
.end method

.method public responseBodyEnd(Lokhttp3/Call;J)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;J)V

    return-void
.end method

.method public responseBodyStart()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->responseBodyStart(Lokhttp3/Call;)V

    return-void
.end method

.method public responseBodyStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->e(Ljava/lang/Object;)V

    return-void
.end method

.method public responseHeadersEnd(Lokhttp3/Call;Lokhttp3/Response;)V
    .locals 5

    if-nez p1, :cond_0

    return-void

    :cond_0
    const-string v0, ""

    const/4 v1, 0x0

    if-eqz p2, :cond_2

    .line 2
    invoke-virtual {p2}, Lokhttp3/Response;->code()I

    move-result v2

    .line 3
    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 5
    invoke-virtual {v3}, Lokhttp3/Headers;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v4, 0x65

    if-ne v2, v4, :cond_1

    const-string v4, "upgrade"

    .line 9
    invoke-virtual {v3, v4}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 10
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-virtual {v3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    const-string v4, "websocket"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v1, 0x1

    :cond_1
    const-string v3, "Content-Type"

    .line 16
    invoke-virtual {p2, v3}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_2
    const/4 v2, -0x1

    move-object p2, v0

    :goto_0
    iget-object v3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 19
    invoke-virtual {v3, p1, v0, v2, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;ILjava/lang/String;)V

    if-eqz v1, :cond_3

    iget-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 22
    invoke-virtual {p2, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;)V

    :cond_3
    return-void
.end method

.method public responseHeadersEnd(Lokhttp3/Response;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->responseHeadersEnd(Lokhttp3/Call;Lokhttp3/Response;)V

    return-void
.end method

.method public responseHeadersStart()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->responseHeadersStart(Lokhttp3/Call;)V

    return-void
.end method

.method public responseHeadersStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->f(Ljava/lang/Object;)V

    return-void
.end method

.method public secureConnectEnd(Lokhttp3/Call;Lokhttp3/Handshake;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    if-eqz p2, :cond_1

    .line 2
    invoke-virtual {p2}, Lokhttp3/Handshake;->tlsVersion()Lokhttp3/TlsVersion;

    move-result-object p2

    if-eqz p2, :cond_1

    .line 4
    invoke-virtual {p2}, Lokhttp3/TlsVersion;->javaName()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_1
    const-string p2, ""

    :goto_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 8
    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->e(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method

.method public secureConnectEnd(Lokhttp3/Handshake;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->secureConnectEnd(Lokhttp3/Call;Lokhttp3/Handshake;)V

    return-void
.end method

.method public secureConnectStart()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a()Lokhttp3/Call;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->secureConnectStart(Lokhttp3/Call;)V

    return-void
.end method

.method public secureConnectStart(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->g(Ljava/lang/Object;)V

    return-void
.end method

.method public setCall(Lokhttp3/Call;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 1
    :cond_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sget-object p1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;->a:Ljava/lang/ThreadLocal;

    .line 2
    invoke-virtual {p1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    return-void
.end method
