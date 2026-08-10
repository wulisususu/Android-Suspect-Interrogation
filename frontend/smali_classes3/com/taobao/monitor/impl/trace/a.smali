.class public Lcom/taobao/monitor/impl/trace/a;
.super Ljava/lang/Object;
.source "AbsDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/IDispatcher;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/trace/a$d;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<",
        "LISTENER:Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/IDispatcher<",
        "T",
        "LISTENER;",
        ">;"
    }
.end annotation


# instance fields
.field private final a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "T",
            "LISTENER;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method protected constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/trace/a;->a:Ljava/util/List;

    const-string v0, " init"

    const-string v1, "AbsDispatcher"

    .line 5
    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method private a()Ljava/lang/Class;
    .locals 2

    .line 5
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getGenericSuperclass()Ljava/lang/reflect/Type;

    move-result-object v0

    .line 6
    instance-of v1, v0, Ljava/lang/reflect/ParameterizedType;

    if-eqz v1, :cond_2

    .line 7
    check-cast v0, Ljava/lang/reflect/ParameterizedType;

    invoke-interface {v0}, Ljava/lang/reflect/ParameterizedType;->getActualTypeArguments()[Ljava/lang/reflect/Type;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 8
    array-length v1, v0

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 11
    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Class;

    return-object v0

    .line 12
    :cond_1
    :goto_0
    const-class v0, Ljava/lang/Object;

    return-object v0

    .line 16
    :cond_2
    const-class v0, Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/trace/a;)Ljava/util/List;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/taobao/monitor/impl/trace/a;->a:Ljava/util/List;

    return-object p0
.end method

.method private a(Ljava/lang/Runnable;)V
    .locals 1

    .line 17
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/trace/a;Ljava/lang/Object;)Z
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/trace/a;->a(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method private a(Ljava/lang/Object;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(T",
            "LISTENER;",
            ")Z"
        }
    .end annotation

    .line 3
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/a;->a()Ljava/lang/Class;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Ljava/lang/Object;Ljava/lang/Class;)Z

    move-result p1

    return p1
.end method

.method private a(Ljava/lang/Object;Ljava/lang/Class;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(T",
            "LISTENER;",
            "Ljava/lang/Class;",
            ")Z"
        }
    .end annotation

    if-nez p2, :cond_0

    const/4 p1, 0x0

    return p1

    .line 4
    :cond_0
    invoke-virtual {p2, p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method


# virtual methods
.method protected final a(Lcom/taobao/monitor/impl/trace/a$d;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/taobao/monitor/impl/trace/a$d<",
            "T",
            "LISTENER;",
            ">;)V"
        }
    .end annotation

    .line 18
    new-instance v0, Lcom/taobao/monitor/impl/trace/a$c;

    invoke-direct {v0, p0, p1}, Lcom/taobao/monitor/impl/trace/a$c;-><init>(Lcom/taobao/monitor/impl/trace/a;Lcom/taobao/monitor/impl/trace/a$d;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public final addListener(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(T",
            "LISTENER;",
            ")V"
        }
    .end annotation

    .line 1
    instance-of v0, p0, Lcom/taobao/monitor/impl/trace/h;

    if-nez v0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    .line 5
    :cond_0
    new-instance v0, Lcom/taobao/monitor/impl/trace/a$a;

    invoke-direct {v0, p0, p1}, Lcom/taobao/monitor/impl/trace/a$a;-><init>(Lcom/taobao/monitor/impl/trace/a;Ljava/lang/Object;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Ljava/lang/Runnable;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public final removeListener(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(T",
            "LISTENER;",
            ")V"
        }
    .end annotation

    .line 1
    instance-of v0, p0, Lcom/taobao/monitor/impl/trace/h;

    if-nez v0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    .line 5
    :cond_0
    new-instance v0, Lcom/taobao/monitor/impl/trace/a$b;

    invoke-direct {v0, p0, p1}, Lcom/taobao/monitor/impl/trace/a$b;-><init>(Lcom/taobao/monitor/impl/trace/a;Ljava/lang/Object;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Ljava/lang/Runnable;)V

    :cond_1
    :goto_0
    return-void
.end method
