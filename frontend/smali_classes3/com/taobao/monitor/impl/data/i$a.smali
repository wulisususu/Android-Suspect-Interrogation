.class Lcom/taobao/monitor/impl/data/i$a;
.super Ljava/lang/Object;
.source "PageLoadCalculate.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/data/i;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/i;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/i;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/i$a;->a:Lcom/taobao/monitor/impl/data/i;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/i$a;->a:Lcom/taobao/monitor/impl/data/i;

    const/4 v1, 0x0

    .line 1
    invoke-static {v0, v1}, Lcom/taobao/monitor/impl/data/i;->a(Lcom/taobao/monitor/impl/data/i;Lcom/taobao/monitor/impl/data/i$b;)Lcom/taobao/monitor/impl/data/i$b;

    return-void
.end method
