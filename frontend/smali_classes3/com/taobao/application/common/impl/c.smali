.class Lcom/taobao/application/common/impl/c;
.super Ljava/lang/Object;
.source "AppLaunchListenerGroup.java"

# interfaces
.implements Lcom/taobao/application/common/IAppLaunchListener;
.implements Lcom/taobao/application/common/impl/f;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/application/common/IAppLaunchListener;",
        "Lcom/taobao/application/common/impl/f<",
        "Lcom/taobao/application/common/IAppLaunchListener;",
        ">;"
    }
.end annotation


# instance fields
.field private final a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/application/common/IAppLaunchListener;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/taobao/application/common/impl/c;->a:Ljava/util/List;

    return-void
.end method

.method static synthetic a(Lcom/taobao/application/common/impl/c;)Ljava/util/List;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/taobao/application/common/impl/c;->a:Ljava/util/List;

    return-object p0
.end method

.method private a(Ljava/lang/Runnable;)V
    .locals 1

    .line 4
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/application/common/IAppLaunchListener;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 2
    new-instance v0, Lcom/taobao/application/common/impl/c$a;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/c$a;-><init>(Lcom/taobao/application/common/impl/c;Lcom/taobao/application/common/IAppLaunchListener;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/c;->a(Ljava/lang/Runnable;)V

    return-void

    .line 3
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public bridge synthetic addListener(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/application/common/IAppLaunchListener;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/c;->a(Lcom/taobao/application/common/IAppLaunchListener;)V

    return-void
.end method

.method public b(Lcom/taobao/application/common/IAppLaunchListener;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/c$b;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/c$b;-><init>(Lcom/taobao/application/common/impl/c;Lcom/taobao/application/common/IAppLaunchListener;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/c;->a(Ljava/lang/Runnable;)V

    return-void

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public onLaunchChanged(II)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/c$c;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/application/common/impl/c$c;-><init>(Lcom/taobao/application/common/impl/c;II)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/c;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public bridge synthetic removeListener(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/application/common/IAppLaunchListener;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/c;->b(Lcom/taobao/application/common/IAppLaunchListener;)V

    return-void
.end method
