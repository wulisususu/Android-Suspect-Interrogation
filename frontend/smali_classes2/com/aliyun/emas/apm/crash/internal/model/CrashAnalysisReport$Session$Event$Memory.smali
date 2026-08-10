.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Memory"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/u$b;-><init>()V

    return-object v0
.end method


# virtual methods
.method public abstract getDalvikPrivateDirty()I
.end method

.method public abstract getDalvikPss()I
.end method

.method public abstract getDalvikSharedDirty()I
.end method

.method public abstract getMemoryStat()Ljava/lang/String;
.end method

.method public abstract getNativePrivateDirty()I
.end method

.method public abstract getNativePss()I
.end method

.method public abstract getNativeSharedDirty()I
.end method

.method public abstract getOtherPrivateDirty()I
.end method

.method public abstract getOtherPss()I
.end method

.method public abstract getOtherSharedDirty()I
.end method

.method public abstract getTotalPrivateClean()I
.end method

.method public abstract getTotalPrivateDirty()I
.end method

.method public abstract getTotalPss()I
.end method

.method public abstract getTotalSharedClean()I
.end method

.method public abstract getTotalSharedDirty()I
.end method

.method public abstract getTotalSwappablePss()I
.end method
