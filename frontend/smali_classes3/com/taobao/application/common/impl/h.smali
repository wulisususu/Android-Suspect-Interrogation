.class Lcom/taobao/application/common/impl/h;
.super Ljava/lang/Object;
.source "PageFpsListenerGroup.java"

# interfaces
.implements Lcom/taobao/application/common/IPageFpsListener;
.implements Lcom/taobao/application/common/impl/f;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/application/common/IPageFpsListener;",
        "Lcom/taobao/application/common/impl/f<",
        "Lcom/taobao/application/common/IPageFpsListener;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/taobao/application/common/IPageFpsListener;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/h;->a:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic a(Lcom/taobao/application/common/impl/h;)Ljava/util/ArrayList;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/taobao/application/common/impl/h;->a:Ljava/util/ArrayList;

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
.method public a(Lcom/taobao/application/common/IPageFpsListener;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 2
    new-instance v0, Lcom/taobao/application/common/impl/h$a;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/h$a;-><init>(Lcom/taobao/application/common/impl/h;Lcom/taobao/application/common/IPageFpsListener;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/h;->a(Ljava/lang/Runnable;)V

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
    check-cast p1, Lcom/taobao/application/common/IPageFpsListener;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/h;->a(Lcom/taobao/application/common/IPageFpsListener;)V

    return-void
.end method

.method public b(Lcom/taobao/application/common/IPageFpsListener;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/h$b;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/h$b;-><init>(Lcom/taobao/application/common/impl/h;Lcom/taobao/application/common/IPageFpsListener;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/h;->a(Ljava/lang/Runnable;)V

    return-void

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V
    .locals 7

    .line 1
    new-instance v6, Lcom/taobao/application/common/impl/h$c;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/taobao/application/common/impl/h$c;-><init>(Lcom/taobao/application/common/impl/h;Ljava/lang/String;Ljava/lang/Object;IF)V

    invoke-direct {p0, v6}, Lcom/taobao/application/common/impl/h;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public bridge synthetic removeListener(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/application/common/IPageFpsListener;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/h;->b(Lcom/taobao/application/common/IPageFpsListener;)V

    return-void
.end method
