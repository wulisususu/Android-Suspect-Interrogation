.class Lcom/aliyun/emas/apm/concurrent/i$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/concurrent/i;->execute(Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Runnable;

.field final synthetic b:Lcom/aliyun/emas/apm/concurrent/i;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/concurrent/i;Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/i$a;->b:Lcom/aliyun/emas/apm/concurrent/i;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/i$a;->a:Ljava/lang/Runnable;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i$a;->a:Ljava/lang/Runnable;

    .line 1
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i$a;->a:Ljava/lang/Runnable;

    .line 1
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
