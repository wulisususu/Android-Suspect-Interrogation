.class Lcom/taobao/application/common/impl/i;
.super Ljava/lang/Object;
.source "PageListenerGroup.java"

# interfaces
.implements Lcom/taobao/application/common/IPageListener;
.implements Lcom/taobao/application/common/impl/f;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/application/common/IPageListener;",
        "Lcom/taobao/application/common/impl/f<",
        "Lcom/taobao/application/common/IPageListener;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/taobao/application/common/IPageListener;",
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

    iput-object v0, p0, Lcom/taobao/application/common/impl/i;->a:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic a(Lcom/taobao/application/common/impl/i;)Ljava/util/ArrayList;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/taobao/application/common/impl/i;->a:Ljava/util/ArrayList;

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
.method public a(Lcom/taobao/application/common/IPageListener;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 2
    new-instance v0, Lcom/taobao/application/common/impl/i$b;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/i$b;-><init>(Lcom/taobao/application/common/impl/i;Lcom/taobao/application/common/IPageListener;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/i;->a(Ljava/lang/Runnable;)V

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
    check-cast p1, Lcom/taobao/application/common/IPageListener;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/i;->a(Lcom/taobao/application/common/IPageListener;)V

    return-void
.end method

.method public b(Lcom/taobao/application/common/IPageListener;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/i$c;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/i$c;-><init>(Lcom/taobao/application/common/impl/i;Lcom/taobao/application/common/IPageListener;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/i;->a(Ljava/lang/Runnable;)V

    return-void

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public onPageChanged(Ljava/lang/String;IJ)V
    .locals 7

    .line 1
    new-instance v6, Lcom/taobao/application/common/impl/i$a;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/application/common/impl/i$a;-><init>(Lcom/taobao/application/common/impl/i;Ljava/lang/String;IJ)V

    invoke-direct {p0, v6}, Lcom/taobao/application/common/impl/i;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public bridge synthetic removeListener(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/application/common/IPageListener;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/i;->b(Lcom/taobao/application/common/IPageListener;)V

    return-void
.end method
