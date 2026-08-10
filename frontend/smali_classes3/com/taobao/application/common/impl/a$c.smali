.class Lcom/taobao/application/common/impl/a$c;
.super Ljava/lang/Object;
.source "ApmEventListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/a;->b(Lcom/taobao/application/common/IApmEventListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/application/common/IApmEventListener;

.field final synthetic a:Lcom/taobao/application/common/impl/a;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/a;Lcom/taobao/application/common/IApmEventListener;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/a$c;->a:Lcom/taobao/application/common/impl/a;

    iput-object p2, p0, Lcom/taobao/application/common/impl/a$c;->a:Lcom/taobao/application/common/IApmEventListener;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/application/common/impl/a$c;->a:Lcom/taobao/application/common/impl/a;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/a;->a(Lcom/taobao/application/common/impl/a;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/a$c;->a:Lcom/taobao/application/common/IApmEventListener;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    return-void
.end method
