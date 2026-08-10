.class public Lcom/taobao/monitor/impl/trace/g;
.super Ljava/lang/Object;
.source "DispatcherManager.java"


# static fields
.field private static a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/monitor/impl/trace/IDispatcher;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/trace/g;->a:Ljava/util/Map;

    return-void
.end method

.method public static a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/trace/g;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/taobao/monitor/impl/trace/IDispatcher;

    if-nez p0, :cond_0

    .line 3
    sget-object p0, Lcom/taobao/monitor/impl/trace/h;->a:Lcom/taobao/monitor/impl/trace/h;

    :cond_0
    return-object p0
.end method

.method public static a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/trace/g;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public static a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z
    .locals 1

    if-eqz p0, :cond_1

    .line 4
    sget-object v0, Lcom/taobao/monitor/impl/trace/h;->a:Lcom/taobao/monitor/impl/trace/h;

    if-ne p0, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method
