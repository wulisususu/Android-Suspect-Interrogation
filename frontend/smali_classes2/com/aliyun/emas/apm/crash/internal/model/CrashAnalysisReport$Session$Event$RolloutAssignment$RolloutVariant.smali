.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "RolloutVariant"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/w$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/w$b;-><init>()V

    return-object v0
.end method


# virtual methods
.method public abstract getRolloutId()Ljava/lang/String;
.end method

.method public abstract getVariantId()Ljava/lang/String;
.end method
