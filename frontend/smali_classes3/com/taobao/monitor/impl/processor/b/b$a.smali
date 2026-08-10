.class Lcom/taobao/monitor/impl/processor/b/b$a;
.super Ljava/lang/Object;
.source "WeexProcessor.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/processor/b/b;->a(IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/processor/b/b;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/processor/b/b;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b$a;->a:Lcom/taobao/monitor/impl/processor/b/b;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b$a;->a:Lcom/taobao/monitor/impl/processor/b/b;

    .line 1
    invoke-virtual {v0}, Lcom/taobao/monitor/impl/processor/b/b;->c()V

    return-void
.end method
