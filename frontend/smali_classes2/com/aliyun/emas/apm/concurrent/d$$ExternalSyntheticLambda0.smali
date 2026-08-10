.class public final synthetic Lcom/aliyun/emas/apm/concurrent/d$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/concurrent/d;

.field public final synthetic f$1:Ljava/lang/Runnable;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/concurrent/d;Ljava/lang/Runnable;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/d$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/concurrent/d;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/d$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Runnable;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/d$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/concurrent/d;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/d$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Runnable;

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/concurrent/d;->$r8$lambda$ZfmIBTWmKROWYF5M1C-omI62WVQ(Lcom/aliyun/emas/apm/concurrent/d;Ljava/lang/Runnable;)V

    return-void
.end method
