.class public final synthetic Lcom/aliyun/emas/apm/crash/u0$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/google/android/gms/tasks/Continuation;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/crash/u0;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/u0;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/u0$$ExternalSyntheticLambda1;->f$0:Lcom/aliyun/emas/apm/crash/u0;

    return-void
.end method


# virtual methods
.method public final then(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0$$ExternalSyntheticLambda1;->f$0:Lcom/aliyun/emas/apm/crash/u0;

    invoke-static {v0, p1}, Lcom/aliyun/emas/apm/crash/u0;->$r8$lambda$ztNpGdYFrD9KvLzqxYPXMwdURKE(Lcom/aliyun/emas/apm/crash/u0;Lcom/google/android/gms/tasks/Task;)Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method
