.class public abstract Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<C:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private final a:Ljava/lang/Runnable;

.field private final a:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 5
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$k;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$k;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;)Ljava/lang/Runnable;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/net/InetSocketAddress;)Ljava/lang/String;
    .locals 0

    .line 3
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/net/InetSocketAddress;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private a(Ljava/net/InetSocketAddress;)Ljava/lang/String;
    .locals 0

    if-eqz p1, :cond_0

    .line 46
    invoke-virtual {p1}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 48
    invoke-virtual {p1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object p0
.end method


# virtual methods
.method protected abstract a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)",
            "Lcom/alibaba/sdk/android/networkmonitor/a;"
        }
    .end annotation
.end method

.method protected abstract a()Ljava/lang/String;
.end method

.method protected abstract a()V
.end method

.method protected a(Lcom/alibaba/sdk/android/networkmonitor/a;)V
    .locals 10

    const-string v0, "ALI_APM/"

    if-eqz p1, :cond_0

    .line 36
    :try_start_0
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/networkmonitor/a;->toString()Ljava/lang/String;

    move-result-object v7

    .line 37
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1, v7}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->b(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;

    move-result-object p1

    check-cast p1, Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 40
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a()Lcom/alibaba/sdk/android/emas/EmasSender;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v4, 0x0

    const v5, 0xee4c

    const-string v6, "AliHANetwork"

    :try_start_1
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 41
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lcom/ut/device/UTDevice;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "/monitor/procedure/network"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const/4 v9, 0x0

    .line 42
    invoke-virtual/range {v1 .. v9}, Lcom/alibaba/sdk/android/emas/EmasSender;->send(JLjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 45
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void
.end method

.method public a(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)V"
        }
    .end annotation

    .line 27
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 29
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$o;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$o;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;I)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;I)V"
        }
    .end annotation

    .line 21
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 22
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v6

    new-instance v7, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$c;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$c;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JI)V

    invoke-virtual {v6, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;J)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;J)V"
        }
    .end annotation

    .line 23
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 24
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v7

    new-instance v8, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$i;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move-wide v5, p2

    invoke-direct/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$i;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JJ)V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected abstract a(Ljava/lang/Object;Lcom/alibaba/sdk/android/networkmonitor/a;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Lcom/alibaba/sdk/android/networkmonitor/a;",
            ")V"
        }
    .end annotation
.end method

.method public a(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 6
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 10
    :cond_0
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$u;

    invoke-direct {v1, p0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$u;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/lang/String;ILjava/lang/String;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 25
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 26
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v8

    new-instance v9, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;

    move-object v0, v9

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    move v6, p3

    move-object v7, p4

    invoke-direct/range {v0 .. v7}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;ILjava/lang/String;)V

    invoke-virtual {v8, v9}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 4
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 5
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v8

    new-instance v9, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;

    move-object v0, v9

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    move-object v6, p3

    move-object v7, p4

    invoke-direct/range {v0 .. v7}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v8, v9}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "I)V"
        }
    .end annotation

    .line 19
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    .line 20
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v10

    new-instance v11, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;

    move-object v0, v11

    move-object v1, p0

    move-object v2, p1

    move-object v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    move-object v8, p2

    move/from16 v9, p6

    invoke-direct/range {v0 .. v9}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;I)V

    invoke-virtual {v10, v11}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/lang/String;Ljava/util/List;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/net/InetAddress;",
            ">;)V"
        }
    .end annotation

    .line 11
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 12
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v7

    new-instance v8, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$w;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$w;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;Ljava/util/List;)V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/lang/Throwable;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/Throwable;",
            ")V"
        }
    .end annotation

    .line 30
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 32
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v6

    new-instance v7, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/Throwable;)V

    invoke-virtual {v6, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/net/InetSocketAddress;",
            "Ljava/net/Proxy;",
            ")V"
        }
    .end annotation

    .line 13
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 14
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v7

    new-instance v8, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/net/InetSocketAddress;Ljava/net/Proxy;)V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/net/InetSocketAddress;",
            "Ljava/net/Proxy;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 15
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 16
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object p3

    invoke-virtual {p3}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object p3

    new-instance v7, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$a0;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v5, p4

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$a0;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;Ljava/net/InetSocketAddress;)V

    invoke-virtual {p3, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Ljava/lang/String;Ljava/io/IOException;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/net/InetSocketAddress;",
            "Ljava/net/Proxy;",
            "Ljava/lang/String;",
            "Ljava/io/IOException;",
            ")V"
        }
    .end annotation

    .line 17
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 18
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object p3

    invoke-virtual {p3}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object p3

    new-instance v8, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$a;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move-object v5, p4

    move-object v6, p2

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$a;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;Ljava/net/InetSocketAddress;Ljava/io/IOException;)V

    invoke-virtual {p3, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;Z)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;Z)V"
        }
    .end annotation

    .line 35
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$s;

    invoke-direct {v1, p0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$s;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;Z)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/Object;ZLjava/lang/Throwable;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;Z",
            "Ljava/lang/Throwable;",
            ")V"
        }
    .end annotation

    .line 33
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    .line 34
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v7

    new-instance v8, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$r;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move-object v3, p3

    move v6, p2

    invoke-direct/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$r;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;Ljava/lang/Throwable;JZ)V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected abstract b(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)",
            "Lcom/alibaba/sdk/android/networkmonitor/a;"
        }
    .end annotation
.end method

.method public b(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)V"
        }
    .end annotation

    .line 5
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 7
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$q;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$q;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public b(Ljava/lang/Object;J)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;J)V"
        }
    .end annotation

    .line 3
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 4
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v7

    new-instance v8, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$n;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move-wide v5, p2

    invoke-direct/range {v0 .. v6}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$n;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JJ)V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public b(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v6

    new-instance v7, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$v;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$v;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;)V

    invoke-virtual {v6, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public c(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)V"
        }
    .end annotation

    .line 4
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 5
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public c(Ljava/lang/Object;J)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;J)V"
        }
    .end annotation

    .line 3
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$g;

    invoke-direct {v1, p0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$g;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public c(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v6

    new-instance v7, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$e;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$e;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;)V

    invoke-virtual {v6, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public d(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)V"
        }
    .end annotation

    .line 3
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 4
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$f;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$f;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public d(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v6

    new-instance v7, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$d;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$d;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;)V

    invoke-virtual {v6, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public e(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)V"
        }
    .end annotation

    .line 3
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 4
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$m;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$m;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public e(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v6

    new-instance v7, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$z;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$z;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;)V

    invoke-virtual {v6, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public f(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)V"
        }
    .end annotation

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$j;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$j;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public g(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)V"
        }
    .end annotation

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$y;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$y;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
