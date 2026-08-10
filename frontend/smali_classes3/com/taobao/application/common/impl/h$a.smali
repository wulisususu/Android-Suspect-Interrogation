.class Lcom/taobao/application/common/impl/h$a;
.super Ljava/lang/Object;
.source "PageFpsListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/h;->a(Lcom/taobao/application/common/IPageFpsListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/application/common/IPageFpsListener;

.field final synthetic a:Lcom/taobao/application/common/impl/h;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/h;Lcom/taobao/application/common/IPageFpsListener;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/h$a;->a:Lcom/taobao/application/common/impl/h;

    iput-object p2, p0, Lcom/taobao/application/common/impl/h$a;->a:Lcom/taobao/application/common/IPageFpsListener;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/application/common/impl/h$a;->a:Lcom/taobao/application/common/impl/h;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/h;->a(Lcom/taobao/application/common/impl/h;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/h$a;->a:Lcom/taobao/application/common/IPageFpsListener;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/application/common/impl/h$a;->a:Lcom/taobao/application/common/impl/h;

    .line 2
    invoke-static {v0}, Lcom/taobao/application/common/impl/h;->a(Lcom/taobao/application/common/impl/h;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/h$a;->a:Lcom/taobao/application/common/IPageFpsListener;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method
