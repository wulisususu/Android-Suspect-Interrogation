.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Device"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/g$b;-><init>()V

    return-object v0
.end method


# virtual methods
.method public abstract getArch()I
.end method

.method public abstract getBrand()Ljava/lang/String;
.end method

.method public abstract getCores()I
.end method

.method public abstract getDiskSpace()J
.end method

.method public abstract getLanguage()Ljava/lang/String;
.end method

.method public abstract getManufacturer()Ljava/lang/String;
.end method

.method public abstract getModel()Ljava/lang/String;
.end method

.method public abstract getModelClass()Ljava/lang/String;
.end method

.method public abstract getOs()Ljava/lang/String;
.end method

.method public abstract getRam()J
.end method

.method public abstract getResolution()Ljava/lang/String;
.end method

.method public abstract getState()I
.end method

.method public abstract getVersion()Ljava/lang/String;
.end method

.method public abstract isJailbroken()Z
.end method

.method public abstract isSimulator()Z
.end method
