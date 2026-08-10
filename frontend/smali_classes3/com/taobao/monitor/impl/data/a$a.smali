.class Lcom/taobao/monitor/impl/data/a$a;
.super Ljava/lang/Object;
.source "AbstractDataCollector.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/a;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/a$a;->a:Lcom/taobao/monitor/impl/data/a;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a$a;->a:Lcom/taobao/monitor/impl/data/a;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/a;->a(Lcom/taobao/monitor/impl/data/a;)V

    return-void
.end method
